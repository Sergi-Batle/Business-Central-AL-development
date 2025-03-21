tableextension 50400 Customer extends Customer
{
    procedure UpdateCreditLimit(var NewCreditLimit: Decimal)
    begin
        NewCreditLimit := Round(NewCreditLimit, 0.01);
        Message('Credit Limit pinga 2: %1', NewCreditLimit);
        Rec.Validate("Credit Limit (LCY)", NewCreditLimit);
        Rec.Modify();
    end;

    procedure CalculateCreditLimit(): Decimal
    var
        Customer: Record Customer;
    begin
        Customer := Rec;
        Customer.SetRange("Date Filter", CalcDate('<-12M>', WorkDate()), WorkDate());
        Customer.CalcFields("Sales (LCY)", "Balance (LCY)");
        exit(Round(Customer."Sales (LCY)" * 0.5));
    end;
}