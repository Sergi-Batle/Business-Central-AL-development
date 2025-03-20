page 50111 MyImageCardPage
{
    PageType = Card;
    SourceTable = MyImageTable;
    ApplicationArea = All; // La página está disponible en todas las áreas de la aplicación
    UsageCategory = Documents;
    InsertAllowed = false;
    DeleteAllowed = false;
    LinksAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Añadir Mono'; 

                field(Name; Rec.Name)
                {
                    ApplicationArea = All; // El campo está disponible en todas las áreas de la aplicación
                    ShowCaption = true;
                    Editable = true;
                }

                field(Image; Rec."Image") // Mostrar el campo de imagen
                {
                    ApplicationArea = All; // El campo está disponible en todas las áreas de la aplicación
                    ShowCaption = true;
                    // Aquí se mostrará la imagen cargada
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(UploadImage)
            {
                Caption = 'Subir Imagen';
                // Image = Upload; // Se puede agregar un ícono de subir imagen si es necesario
                ApplicationArea = All; // La acción está disponible en todas las áreas de la aplicación

                trigger OnAction()
                var
                    FileName: Text;
                    InS: InStream;
                begin
                    if UploadIntoStream('Seleccionar Imagen', 'Todos los archivos (*.*)|*.*', '', FileName, InS) then begin
                        // Importamos la imagen al campo "Image"
                        Rec."Image".ImportStream(InS, FileName);
                        Rec.Modify(); // Aseguramos que se guarde el registro con la imagen
                        CurrPage.Update(); // Actualizamos la página para mostrar la imagen
                        MESSAGE('Imagen importada correctamente.');
                    end;
                end;
            }

            action(Save)
            {
                Caption = 'Guardar';
                Image = Save;
                ApplicationArea = All; // La acción está disponible en todas las áreas de la aplicación

                trigger OnAction()
                begin
                    if Rec."Name" = '' then begin
                        Message('El campo Nombre es obligatorio.');
                        exit;
                    end;

                    if Rec."Image".HasValue() then begin
                        Rec.Insert(); // Insertar el nuevo registro en la tabla
                        Message('Registro guardado exitosamente.');
                    end else begin
                        Message('Debe subir una imagen antes de guardar.');
                    end;
                end;
            }
        }
    }
}
