page 50101 "BCA Beer Setup"
{
    PageType = Card;
    Caption = 'Beer Setup';
    SourceTable = "BCA Beer Setup";
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';
                field("Azure URL"; "Azure URL")
                {
                    ApplicationArea = All;
                }
                field("Azure Function Name"; "Azure Function Name")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage();
    begin
        Reset();
        if not Get() then begin
            init();
            Insert();
        end;
    end;
}