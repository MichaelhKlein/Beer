page 50100 "BCA Beer Category List"
{
    PageType = List;
    SourceTable = "BCA Beer Category";
    Caption = 'Beer Category List';

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {

        }
    }

    actions
    {
        area(processing)
        {
            action(Export)
            {
                Caption = 'Export';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Export;
                trigger OnAction();
                var
                    BCASettingsMgt: Codeunit "BCA Settings Management";
                begin
                    BCASettingsMgt.ExportBeerCategories();
                end;
            }
            action(Import)
            {
                Caption = 'Import';
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Import;
                trigger OnAction();
                var
                    BCASettingsMgt: Codeunit "BCA Settings Management";
                begin
                    BCASettingsMgt.ImportBeerCategories();
                end;
            }
            action(AzureCategories)
            {
                Caption = 'Get Beer Categories from Azure';
                Image = Web;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;
                trigger OnAction();
                var
                    AzureFunctions: Codeunit "BCA Azure Function";
                begin
                    AzureFunctions.GetBeerCategoriesAzure();
                end;
            }
        }
    }
}