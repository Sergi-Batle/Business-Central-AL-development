page 50101 MyImagePage
{
    PageType = Card;
    SourceTable = MyImageTable;
    ApplicationArea = All;
    UsageCategory = Documents;
    InsertAllowed = true;

    layout
    {
        area(content)
        {
            field(Name; Rec."Name")
            {
                ApplicationArea = All;
                ShowCaption = true;
                Editable = true;
            }

            field(Image; Rec."Image")
            {
                ApplicationArea = All;
                ShowCaption = false;

                // Ajustar el tamaño de la imagen
                StyleExpr = 'width: 300px; height: 300px;';
            }

        }
    }

    actions
    {

        area(creation)
        {

            action(NewRecord)
            {
                Caption = 'Añadir monito';
                ApplicationArea = All;
                Image = New;

                trigger OnAction()
                begin
                    if not Rec."Image".HasValue then begin
                        if Rec."Name" = '' then begin
                            Message('Faltan los dos campos');
                        end;
                    end;

                    if Rec."Name" = '' then begin
                        Message('El campo Nombre es obligatorio.');
                        exit;
                    end;

                    if not Rec."Image".HasValue then begin
                        Message('El campo Imagen es obligatorio.');
                        exit;
                    end;

                    

                    // Crear un nuevo registro
                    Rec.Init();
                    Rec.Insert(true);
                    CurrPage.Update(); // Actualizamos la página para mostrar el nuevo registro
                    Message('Nuevo registro creado.');
                end;
            }

        }




        area(processing)
        {
            action(ImportImage)
            {
                Caption = 'Importar Imagen';
                ApplicationArea = All;
                Image = Import;

                trigger OnAction()
                var
                    FileName: Text;
                    InS: InStream;
                begin
                    if UploadIntoStream('Seleccionar Imagen', 'Todos los archivos (*.*)|*.*', '', FileName, InS) then begin
                        Rec."Image".ImportStream(InS, FileName);
                        Rec.Modify();
                        Message('Imagen importada correctamente.');
                    end;
                end;
            }
        }
    }
}