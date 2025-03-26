query 50133 "Customer Overview Query"
{
    Caption = 'Customer Overview Query';
    QueryType = Normal;

    elements
    {
        dataitem(CustomerOverviewTable; "Customer Overview Table")
        {
            column(EntryNo; "Entry No.")
            {
            }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerName; "Customer Name")
            {
            }
            column(SourceCode; "Source Code")
            {
            }
            column(Amount; Amount)
            {
            }
            column(LastRundate; LastRundate)
            {
            }
        }
    }
}