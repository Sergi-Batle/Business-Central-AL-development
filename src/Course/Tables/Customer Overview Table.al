table 50133 "Customer Overview Table"
{
    Caption = 'Customer Overview Table';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1;"Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            
        }

        field(2; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(3; "Customer Name"; Text[100]) 
        {
            DataClassification = ToBeClassified;
        }

        field(4; "Source Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(5; "Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
        }

        field(6; "LastRundate"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
    }
}