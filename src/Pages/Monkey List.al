page 50110 MyImageListPage
{
    PageType = List;
    SourceTable = MyImageTable;
    ApplicationArea = All;
    UsageCategory = Documents;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Name; Rec."Name")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part(MyImageViewPage; "MyImageViewPage")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(AddNew)
            {
                Caption = 'Añadir Nuevo';
                Image = New;

                trigger OnAction()
                var
                    NewCardPage: Page "MyImageCardPage";
                begin
                    // Abrir la página para crear un nuevo registro
                    PAGE.RunModal(PAGE::"MyImageCardPage");
                end;
            }

            action(ViewDetails)
            {
                Caption = 'Ver Detalles';
                // Image = Information;

                trigger OnAction()
                var
                    MyCardPage: Page "MyImageCardPage";
                begin
                    // Abrir la página para ver detalles del registro seleccionado
                    PAGE.RunModal(PAGE::"MyImageCardPage");
                end;
            }
        }
    }
}
