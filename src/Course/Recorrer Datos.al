pageextension 50122 "Recorrer Datos" extends "Vendor List"
{
    trigger OnOpenPage()
    var
        monkeys: Record MyImageTable;

        Names: Text;
    begin
        if monkeys.FindSet() then begin
            repeat
                Names += monkeys."Name" + '\n';
            until monkeys.Next() = 0;
            Message(Names);
        end;
    end;


}