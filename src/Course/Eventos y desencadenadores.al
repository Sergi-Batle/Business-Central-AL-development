pageextension 50120 Pinga extends "Customer Card"
{


    trigger OnOpenPage()
    var
        test: Codeunit CodeTest;
    begin
        test.increaseCounter();
    end;

}

codeunit 50120 CodeTest
{
    SingleInstance = true;
     procedure increaseCounter()
    begin
        Contador += 1;
        Message('Contador: %1', Contador);
    end;


    var
        Contador: Integer;

}

codeunit 50111 Validations
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterValidateEvent', 'Address', false, false)]
    local procedure TableCustomerOnAfterValidateEventAddress(var Rec: Record Customer)
    begin
        CheckForPlusSign(Rec.Address);
    end;


    local procedure CheckForPlusSign(TextToVerify: Text)
    begin
        if TextToVerify.Contains('+') then
            Message('A + sign has been found.');
    end;
}

