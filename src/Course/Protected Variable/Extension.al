pageextension 50101 MyPageExt extends MyPage
{
    layout
    {
        addlast(Content)
        {
            group(MoreBalance)
            {
                Visible = ShowBalance; // ShowBalance from MyPage

                field("Balance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        addlast(Navigation)
        {
            action(ToggleBalance)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ShowBalance := not ShowBalance; // Toggle ShowBalance from MyPage.
                end;
            }
        }
    }
}