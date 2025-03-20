page 50117 Exam1
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Logical and Relational';

    layout
    {
        area(Content)
        {
            group(Entrada)
            {
                Caption = 'Input';
                field(Value1; Value1)
                {
                    ApplicationArea = All;
                    ToolTip = 'Introduce un valor';
                }

                field(Value2; Value2)
                {
                    ApplicationArea = All;
                    ToolTip = 'Introduce un valor';
                }
            }

            group(Salida)
            {
                Caption='Salida';
                field(Result;Result)
                {
                    ApplicationArea=All;
                    Caption='Resultado';
                    ToolTip='Resultado de la operacion';
                    Editable=false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Execute)
            {
                ApplicationArea = All;
                Caption = 'Execute';
                ToolTip = 'Click to calculate the result.';
                Image = ExecuteBatch;

                trigger OnAction()
                begin
                    Result := '';
                    if (Value1 > Value2) then
                        Result := 'Es mayor'
                    else if (Value1 = Value2) then
                        Result := 'ES IGUAL'    
                    else
                        Result := 'Es menor';
                end;
            }
        }
    }

    var
        Value1: Integer;
        Value2: Integer;
        Result: Text[20];
}