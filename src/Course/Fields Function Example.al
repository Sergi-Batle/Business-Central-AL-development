page 50124 "Field Functions Example"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "FlowField Table";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.") { ApplicationArea = All; }
                field(Name; Rec.Name) { ApplicationArea = All; }
                field(Amount; Rec.Amount) { ApplicationArea = All; }
                field("Salesperson Code"; Rec."Salesperson Code") { ApplicationArea = All; }
                field("Phone No."; Rec."Phone No.") { ApplicationArea = All; }
                field("E-Mail"; Rec."E-Mail") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CalcFieldsExample)
            {
                ApplicationArea = All;
                Caption = 'CalcFields Example';
                trigger OnAction()
                begin
                    Rec.CalcFields(Amount);
                    Message('Amount: %1', Rec.Amount);
                end;
            }
            action(SetAutoCalcFieldsExample)
            {
                ApplicationArea = All;
                Caption = 'SetAutoCalcFields Example';
                trigger OnAction()
                begin
                    Rec.SetAutoCalcFields(Amount);
                    Message('Amount: %1', Rec.Amount);
                end;
            }
            // action(CalcSumsExample)
            // {
            //     ApplicationArea = All;
            //     Caption = 'CalcSums Example';
            //     trigger OnAction()
            //     var
            //         FlowFieldTable: Record "FlowField Table";
            //     begin
            //         FlowFieldTable.SetRange("No.", '10000', '20000');
            //         if FlowFieldTable.FindSet() then begin
            //             FlowFieldTable.CalcSums(Amount);
            //             Message('Total Amount: %1', FlowFieldTable.Amount);
            //         end;
            //     end;
            // }
            action("Insertar registros")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    CustomerRec: Record Customer;
                    FlowFieldTableRec: Record "FlowField Table";
                begin
                    if CustomerRec.FindSet() then begin
                        repeat
                            Clear(FlowFieldTableRec);
                            FlowFieldTableRec."No." := CustomerRec."No.";
                            FlowFieldTableRec.Name := CustomerRec.Name;
                            FlowFieldTableRec."Salesperson Code" := CustomerRec."Salesperson Code";
                            FlowFieldTableRec."Phone No." := CustomerRec."Phone No.";
                            FlowFieldTableRec."E-Mail" := CustomerRec."E-Mail";

                            FlowFieldTableRec.Insert(true);
                        until CustomerRec.Next() = 0;
                    end;
                    Message('Customers copied successfully!');
                end;
            }

            action(FieldErrorExample)
            {
                ApplicationArea = All;
                Caption = 'FieldError Example';
                trigger OnAction()
                begin
                    if Rec.Amount < 0 then
                        Rec.FieldError(Rec.Amount, 'Amount must be positive');
                    Message('Amount is valid.');
                end;
            }
            action(InitExample)
            {
                ApplicationArea = All;
                Caption = 'Init Example';
                trigger OnAction()
                begin
                    Rec.Init();
                    Rec.Name := 'John Doe';
                    Rec."E-Mail" := 'john.doe@contoso.com';
                    Rec.Insert(true);
                    Message('Record initialized and inserted.');
                end;
            }
            action(TestFieldExample)
            {
                ApplicationArea = All;
                Caption = 'TestField Example';
                trigger OnAction()
                begin
                    Rec.TestField("Salesperson Code");
                    Message('Salesperson Code is not empty.');
                    Rec."Salesperson Code" := 'DK';
                    Rec.TestField("Salesperson Code", 'ZX');
                    Message('Salesperson Code is ZX.');
                end;
            }
            action(ValidateExample)
            {
                ApplicationArea = All;
                Caption = 'Validate Example';
                trigger OnAction()
                begin
                    Rec."Phone No." := '1234567891234';
                    Rec.Validate("Phone No.");
                    Message('Phone number validated.');
                    Rec.Validate("Phone No.", '1234567891234');
                    Message('Phone number validated and set.');
                end;
            }
        }
    }
}
