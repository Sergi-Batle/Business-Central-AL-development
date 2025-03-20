page 50133 "Customer Overview List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Customer Overview Table";
    Caption = 'Customer Overview List';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {

                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field.';
                    ApplicationArea = All;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.';
                    ApplicationArea = All;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ToolTip = 'Specifies the value of the Source Code field.';
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Specifies the value of the Amount field.';
                    ApplicationArea = All;
                }
                field(LastRunDate; Rec.LastRunDate)
                {
                    ToolTip = 'Specifies the value of the LastRunDate field.';
                    ApplicationArea = All;
                }
            }
        }
    }


    actions {
        area(Processing)
        {
            action("Import Records")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    CustomerOverview: Codeunit "Customer Overview Mgmt";
                begin
                    CustomerOverview.Run();
                end;

            }
            action("Borrar registros")
            {
                ApplicationArea = All;
                trigger OnAction()
                var
                    Registros: Record "Customer Overview Table";
                begin
                    Registros.DeleteAll(true);
                end;
            }
        }
    }

}