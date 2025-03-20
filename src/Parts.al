page 50140 PartsExample
{
    PageType = Card;
    SourceTable = Customer;
    ApplicationArea = All;
    UsageCategory = Documents;
    Caption = 'Customer Details';

    layout
    {
        area(Content)
        {
            group("General Information")
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
            }
        }

        area(FactBoxes)
        {
            part(CustomerStatistics; "Customer Statistics FactBox") { ApplicationArea = All; }
        }
    }

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
        }
    }
}
