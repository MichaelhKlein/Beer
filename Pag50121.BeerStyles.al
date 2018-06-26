page 50121 "BCA Beer Styles"
{
    PageType = List;
    SourceTable = "BCA Beer Style";
    Caption='Beer Styles';
    UsageCategory=Lists;
    ApplicationArea=All;
    layout
    {
        
        area(content)
        {

            repeater(GroupName)
            {
                Caption='General';
                
                field(ID;ID)
                {
                    ApplicationArea=All;
                }
                field("Category ID";"Category ID")
                {
                    ApplicationArea=All;
                }
                //field(Name;Name)
                //{
                //    ApplicationArea=All;
                //}      
                field(Name;"Short Name")
                {
                    ApplicationArea=All;
                }                               
            }
        }
    }
}