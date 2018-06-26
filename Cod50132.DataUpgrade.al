codeunit 50132 "Data Upgrade"
{
    Subtype = Upgrade;
    trigger OnUpgradePerCompany();
    begin
        IF BeerStyleRec.FindSet() then
            repeat
                BeerStyleRec."Short Name" := CopyStr(BeerStyleRec.Name, 1, 20);
                Clear(BeerStyleRec.Name);
                BeerStyleRec.Modify();
            until BeerStyleRec.Next() = 0;
    end;

    var
        BeerStyleRec: Record "BCA Beer Style";
}