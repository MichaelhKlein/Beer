pageextension 50101 "BCA Item Card" extends "Item Card"
{
    layout
    {
        addlast(Content)
        {
            group(BCA_Beer_Category)
            {
                Caption = 'Beer Category';
                field("BCA Beer Category Code";"BCA Beer Category Code")
                {
                    ApplicationArea=All;
                    trigger OnValidate()
                    begin
                        CurrPage.update();
                    end;
                }
                field("BCA Beer Categpry Name";"BCA Beer Categpry Name")
                {
                    ApplicationArea=All;
                    Editable=false;
                }

                
            }
        }
    }
    
    actions
    {
        // Add changes to page actions here
    }
    
    var
        myInt: Integer;
}