page 50103 MyPage
{
    SourceTable = Customer;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Documents;

    layout
    {
        area(Content)
        {
            group(General)
            {
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
            }
            group(Advanced)
            {
                Visible = ShowBalance;

                field(Balance; Rec.Balance)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    protected var
        [InDataSet]
        ShowBalance: Boolean;
}
