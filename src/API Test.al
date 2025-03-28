page 50150 "CustomerAPIPage"
{
    PageType = Card;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(number; rec."No.")
                {
                    Caption = 'No.';

                }
                field(customerName; rec.Name)
                {
                    Caption = 'Customer Name';

                }
                field(vatRegistrationNo; rec."VAT Registration No.")
                {
                    Caption = 'VAT Registration No.';

                }

            }
        }
    }
}