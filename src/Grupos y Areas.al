page 50130 CustomerDetailsPage
{
    PageType = Card;
    SourceTable = Customer;  // Se conecta a la tabla "Customer" de Cronus
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Customer Details';

    layout
    {
        // Área principal donde se muestra la información
        area(Content)
        {
            // Grupo con información general del cliente
            group("General Information")
            {
                field("No."; Rec."No.") { ApplicationArea = All; }  // Código del cliente
                field(Name; Rec.Name) { ApplicationArea = All; }  // Nombre del cliente
                field(Address; Rec.Address) { ApplicationArea = All; }  // Dirección
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }  // Teléfono
            }

            // Grupo con información financiera
            group("Financial Details")
            {
                field("Balance (LCY)"; Rec."Balance (LCY)") { ApplicationArea = All; }  // Balance
                field("Credit Limit (LCY)"; Rec."Credit Limit (LCY)") { ApplicationArea = All; }  // Límite de crédito
            }

            // Repeater para listar contactos relacionados con el cliente
            repeater("Contacts")
            {
                field("Contact Name"; Rec."Primary Contact No.") { ApplicationArea = All; }
                field("Email"; Rec."E-Mail") { ApplicationArea = All; }
            }

            // CueGroup para mostrar métricas clave del cliente
            cuegroup("Customer Metrics")
            {
                field("Total Sales"; Rec."Sales (LCY)") { ApplicationArea = All; }  // Total de ventas en la moneda local
            }
        }

        // Área de FactBoxes para mostrar información adicional
        area(FactBoxes)
        {
            part(CustomerStatistics; "Customer Statistics FactBox") { ApplicationArea = All; }
        }
    }

    // Área de acciones
    actions
    {
        area(Processing)
        {
            action(ShowBalance)
            {
                Caption = 'Show Balance';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Message('The balance of %1 is %2', Rec.Name, Rec."Balance (LCY)");
                end;
            }

            action(UpdateCreditLimit)
            {
                Caption = 'Update Credit Limit';
                ApplicationArea = All;
                trigger OnAction()
                begin
                    Rec."Credit Limit (LCY)" := Rec."Credit Limit (LCY)" + 1000;  // Aumenta el límite de crédito en 1000
                    Message('New credit limit for %1: %2', Rec.Name, Rec."Credit Limit (LCY)");
                    Rec.Modify();  // Guarda el cambio en la base de datos
                end;
            }
        }
    }
}
