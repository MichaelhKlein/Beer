codeunit 50100 "BCA Settings Management"
{
    [EventSubscriber(ObjectType::Table, 50100, 'OnBeforeValidateEvent', 'Code', false, false)]
    local procedure OnBeetCategoryCodeValidate(Rec: Record "BCA Beer Category"; xrec: Record "BCA Beer Category");
    var
        notBeerMessage: Label 'This is not a beer!';
    begin
        if strpos(rec.code, 'WINE') > 0 then error(notBeerMessage);
    end;

    procedure ExportBeerCategories();
    var
        TmpBlob: Record TempBlob temporary;
        BCABeerCategoriesXML: XmlPort "BCA Beer Categories";
        OutStr: OutStream;
        InStr: InStream;
        FileName: Text;
        FileNameLabel: Label 'BeerCategories.xml';
        DialogTitleLabel: Label 'Beer Categories Export';
    begin
        TmpBlob.Init();
        TmpBlob.Blob.CreateOutStream(OutStr);
        BCABeerCategoriesXML.SetDestination(OutStr);
        BCABeerCategoriesXML.Export();
        TmpBlob.Blob.CreateInStream(InStr);
        FileName := FileNameLabel;
        file.DownloadFromStream(InStr, DialogTitleLabel, '', '', FileName);
    end;

    procedure ImportBeerCategories();
    var
        TmpBlob: Record TempBlob temporary;
        BCABeerCategoriesXML: XmlPort "BCA Beer Categories";
        InStr: InStream;
        FileName: Text;
        DialogTitleLabel: Label 'Select XML file for Import';
        FromFilterLabel: Label 'XML Files (*.xml)|*.xml', locked = true;
    begin
        TmpBlob.Init();
        TmpBlob.Blob.CreateInStream(InStr);
        file.UploadIntoStream(DialogTitleLabel, '', FromFilterLabel, FileName, InStr);
        BCABeerCategoriesXML.SetSource(InStr);
        BCABeerCategoriesXML.Import();
    end;

    [EventSubscriber(ObjectType::Table, 1400, 'OnRegisterServiceConnection', '', false, false)]
    local procedure TAB1400_OnRegisterServiceConnection(var ServiceConnection: Record "Service Connection");
    var
        BeerSetup: Record "BCA Beer Setup";
        BeerSetupLabel: Label 'Initial Beer Setup';
    begin
        if not BeerSetup.Get() then begin
            if not BeerSetup.WritePermission() then exit;
            BeerSetup.Init();
            BeerSetup.Insert();
        end;
        ServiceConnection.Status := ServiceConnection.Status::Disabled;
        if (BeerSetup."Azure URL" <> '') and (BeerSetup."Azure Function Name" <> '') then
            ServiceConnection.Status := ServiceConnection.Status::Enabled;
        ServiceConnection.InsertServiceConnection(ServiceConnection, BeerSetup.RecordId(), BeerSetupLabel, '', page::"BCA Initial Setup Wizard");
    end;

    local procedure ShowBeerSetupWarning();
    var
        BeerSetup: Record "BCA Beer Setup";
        BeerNotification: Notification;
        BeerSetupOk: Boolean;
        NotificationText: Label 'Beer Setup isn''t finished. Do you want to run the wizard?';
        RunWizardText: Label 'Run Beer Setup Wizard';
    begin
        if BeerSetup.Get() then BeerSetupOk := (BeerSetup."Azure URL" <> '') and (BeerSetup."Azure Function Name" <> '');
        if not BeerSetupOk then begin
            BeerNotification.Id('cb22876e-ad44-402b-a383-d5cea4b60ad2');
            BeerNotification.Scope(NotificationScope::LocalScope);
            BeerNotification.Message(NotificationText);
            BeerNotification.AddAction(RunWizardText, Codeunit::"BCA Settings Management", 'RunBeerSetupWizard');
            BeerNotification.Send();
        end;
    end;

    [EventSubscriber(ObjectType::page, 1310, 'OnOpenPageEvent', '', false, false)]
    local procedure TAB1310_OnOpenPage();
    begin
        ShowBeerSetupWarning();
    end;

    procedure RunBeerSetupWizard(BeerNotification: Notification);
    begin
        Page.Run(50102);
    end;
}