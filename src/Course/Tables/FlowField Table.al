table 50144 "FlowField Table"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(2; Name; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; Amount; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = Sum("Sales Invoice Line".Amount WHERE("Sell-to Customer No." = FIELD("No."))); // Ejemplo de fórmula
        }
        field(4; "Salesperson Code"; Code[10])
        {
            DataClassification = CustomerContent;
            // ApplicationArea = All; // No se usa en tablas
        }
        field(5; "Phone No."; Text[30])
        {
            DataClassification = CustomerContent;
            // ApplicationArea = All; // No se usa en tablas
        }
        field(6; "E-Mail"; Text[80])
        {
            DataClassification = CustomerContent;
            // ApplicationArea = All; // No se usa en tablas
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
