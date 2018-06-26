codeunit 50102 "BCA Azure Function"
{
   
   
    procedure GetBeerCategoriesAzure();
    var
        HttpClient : HttpClient;
        ResponseMessage : HttpResponseMessage;
        HttpContent : HttpContent;
    begin
        CreateHttpContent(HttpContent);
        HttpClient.Post(GetAzureURL(),HttpContent,ResponseMessage);     
        ProcessHttpResponseMessage(ResponseMessage);
    end;

    local procedure GetAzureURL() : Text;
    var
        BeerSetup : Record "BCA Beer Setup";
        URL : Text;
    begin
        BeerSetup.GET();
        BeerSetup.TestField("Azure URL");
        BeerSetup.TestField("Azure Function Name");
        URL := 'https://' + BeerSetup."Azure URL" + '/api/' + BeerSetup."Azure Function Name";
        exit(URL);    
    end;

    local procedure CreateHttpContent(var HttpContent : HttpContent);
    var
        HttpHeaders : HttpHeaders;
    begin
        HttpContent.GetHeaders(HttpHeaders);
        HttpHeaders.Remove('Content-Type');
        HttpHeaders.Add('Content-Type','application/json');
        HttpContent.WriteFrom('{"WhatToGet" : "Beer"}');        
    end;
    local procedure ProcessHttpResponseMessage(ResponseMessage : HttpResponseMessage);
    var
        TempBeerCategory : Record "BCA Beer Category" temporary;
        BeerCategory : Record "BCA Beer Category";
        Result : Text;
        ResponseData : JsonArray;
        ResponseElement : JsonToken;
        JsonToken : JsonToken;
        
    begin
        if ResponseMessage.IsSuccessStatusCode() then begin
            ResponseMessage.Content().ReadAs(Result);            
            ResponseData.ReadFrom(Result);
            TempBeerCategory.Reset();
            TempBeerCategory.DeleteAll();
            foreach ResponseElement in ResponseData do begin
                Clear(JsonToken);
                ResponseElement.SelectToken('Category',JsonToken);
                if not BeerCategory.get(JsonToken.AsValue().AsText()) then begin
                    TempBeerCategory.Init();
                    TempBeerCategory.Code := COPYSTR(JsonToken.AsValue().AsText(),1,20);
                    Clear(JsonToken);
                    ResponseElement.SelectToken('Description',JsonToken);
                    TempBeerCategory.Name := COPYSTR(JsonToken.AsValue().AsText(),1,50);
                    TempBeerCategory.Insert();
                end;
            end;
            if TempBeerCategory.Count() > 0 then
                if Confirm(StrSubstNo('%1 new Categories were found. Do you want to insert new categories?',TempBeerCategory.Count()),false) then begin
                    TempBeerCategory.Reset();
                    TempBeerCategory.FindSet();
                    repeat
                        BeerCategory.init();
                        BeerCategory.TransferFields(TempBeerCategory);
                        BeerCategory.Insert(true);
                    until TempBeerCategory.next() = 0;
                end;            
        end
        else begin
            ResponseMessage.Content().ReadAs(Result);
            Message('Failed: %1 %2',ResponseMessage.HttpStatusCode(), Result);
        end;        
    end;
}