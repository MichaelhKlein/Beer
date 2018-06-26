pageextension 50100 "BCA Bus Manager Rolecenter" extends "Business Manager Role Center"
{  
    actions
    {
        addlast(Sections)
        {
            group("BCA Beer Categories")
            {
                Caption = 'Beer Categories';
                Image = Administration;
                action(BCA_Beer_Categories_Action)
                {
                    caption = 'Beer Categories';
                    Image = Administration;
                    ApplicationArea=All;
                    RunObject = page "BCA Beer Category List";
                }
                                action(BCA_Beer_Setup)
                {
                    caption = 'Beer Setup';
                    Image = Setup;
                    ApplicationArea=All;
                    RunObject = page "BCA Beer Setup";
                }
            }
        }
    }
    
    var
        myInt: Integer;
}