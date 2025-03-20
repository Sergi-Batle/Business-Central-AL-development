page 50119 Proceder
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    
    layout
    {
        area(Content)
        {
            group("Buscar Monito")
            {
                field(Nombre; nombre)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                Caption = 'Procesar';

                trigger OnAction()
                begin
                    // Aplicamos un filtro para buscar el registro por el nombre ingresado
                    chango.SetRange("Name", nombre);
                    
                    if chango.FindFirst() then begin
                        MESSAGE('Registro encontrado: %1', chango."Name");
                    end else begin
                        MESSAGE('No se encontró un registro con el nombre: %1', nombre);
                    end;
                end;
            }
        }
    }
    
    var
        chango: Record MyImageTable;
        nombre: Text[20]; 
}