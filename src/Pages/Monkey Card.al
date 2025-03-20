page 50112 MyImageViewPage
{
    PageType = CardPart;
    SourceTable = MyImageTable;
    ApplicationArea = All;
    UsageCategory = Documents;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;
    

    layout
    {
        area(content)
        {
                field(Image; Rec."Image") // Mostrar imagen asociada
                {
                    ApplicationArea = All;
                    ShowCaption = true;
                }
        }
    }

    actions
    {
        area(processing)
        {
            action(Back)
            {
                Caption = 'Regresar';
                // Image = Back;

                trigger OnAction()
                begin
                    // Regresar a la página anterior (Lista de imágenes)
                    Close;
                end;
            }
        }
    }
}
