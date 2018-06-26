codeunit 50101 "BCA App Install"
{
    subtype = Install;

    trigger OnInstallAppPerCompany();
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        if AppInfo.DataVersion() = Version.Create(0, 0, 0, 0) then
            HandleInstall() else
            HandleReInstall();
    end;

    local procedure HandleInstall();
    var
        BeerCategory: Record "BCA Beer Category";
    begin
        BeerCategory.Reset();
        BeerCategory.DeleteAll();
        BeerCategory.Init();
        BeerCategory.Validate(Code, 'Initial Category 1');
        BeerCategory.Validate(Name, 'Initial Category 1');
        BeerCategory.Insert(true);
        BeerCategory.Init();
        BeerCategory.Validate(Code, 'Initial Category 2');
        BeerCategory.Validate(Name, 'Initial Category 2');
        BeerCategory.Insert(true);
    end;

    local procedure HandleReInstall();
    var
        BeerCategory: Record "BCA Beer Category";
    begin
        if not BeerCategory.Get('Initial Category 1') then begin
            BeerCategory.Init();
            BeerCategory.Validate(Code, 'Initial Category 1');
            BeerCategory.Validate(Name, 'Initial Category 1 (Restored)');
            BeerCategory.Insert(true);
        end;
        if not BeerCategory.Get('Initial Category 2') then begin
            BeerCategory.Init();
            BeerCategory.Validate(Code, 'Initial Category 2');
            BeerCategory.Validate(Name, 'Initial Category 2 (Restored)');
            BeerCategory.Insert(true);
        end;
    end;
}