table 50121 "BCA Beer Style"
{

    fields
    {
        field(1;ID;Integer)
        {
            Caption='ID';
        }
        field(2;"Category ID";Integer)
        {
            Caption='Category ID';
        }
        field(3;Name;Text[50])
        {
            Caption='Name';
            ObsoleteReason = 'Too long names';
            ObsoleteState = Pending;
        }     
        field(4; "Short Name"; Text[20])
        {
            Caption = 'Short Name';
        }           
    }

    keys
    {
        key(PK;ID,"Category ID")
        {
            Clustered = true;
        }
    }
}