tableextension 50100 "BCA Item" extends Item
{
    fields
    {
        field(50100 ; "BCA Beer Category Code"; Code[20])
        {
            
            DataClassification = ToBeClassified;
            Caption = 'Beer Category Code';
            Tablerelation = "BCA Beer Category";
        }
        field(50101; "BCA Beer Categpry Name"; Text[50])
        {
            Caption = 'Beer Category Name';
            Fieldclass = Flowfield;
            CalcFormula=lookup("BCA Beer Category".Name where (Code=field("BCA Beer Category Code")));
        }
    }
    
    var
        myInt: Integer;
}