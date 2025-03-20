table 50102 MyImageTable
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            AutoIncrement = true;
        }
        field(2; "Image"; Media)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Image".HasValue() = false then
                    Error('The Image field cannot be empty.');
            end;
        }
        field(3; "Name"; Text[20])
        {
            DataClassification = EndUserIdentifiableInformation;
        }
    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
