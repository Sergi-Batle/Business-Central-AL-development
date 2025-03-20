page 50114 SampleCustomerList
{
    PageType = List;
    ApplicationArea = All;
    SourceTable = Customer;
    UsageCategory = Lists;
    // CardPageId = 50112; // Page 50112 is missing
    Caption = 'Sample Customers';

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                }
                field(Phone; Rec."Phone No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("Ledger Entries")
            {
                ApplicationArea = All;
                RunObject = page "Customer Ledger Entries";
            }
        }

        area(Creation)
        {
            action("New Sales Quote")
            {
                ApplicationArea = All;
                RunObject = page "Sales Quote";
                Promoted = true;
                PromotedCategory = New;
                Image = NewSalesQuote;
            }
        }

        area(Reporting)
        {
            action("Top 10 List")
            {
                ApplicationArea = All;
                RunObject = report "Customer - Top 10 List";
            }
        }
    }
}