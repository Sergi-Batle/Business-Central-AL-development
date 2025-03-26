report 50133 "Customer Overview Report"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'ReportLayouts\Test.rdl';
    ApplicationArea = Suite;
    Caption = 'Informando';
    UsageCategory = ReportsAndAnalysis;
    DataAccessIntent = ReadOnly;

    dataset
    {
        dataitem(Customer; "Customer Overview Table")
        {
            column(CustomerName; "Customer Name") { }
            column(Amount; Amount) { }

            trigger OnAfterGetRecord()
            var
                TextVariable: Text;
            begin
                // Ejemplo: Modificar el valor de la columna Amount antes de imprimirla.
                if Amount < 0 then
                    Amount := 0; // Evitar valores negativos.

                // Ejemplo: Mostrar un mensaje en la consola para cada registro procesado.
                TextVariable := StrSubstNo('Procesando cliente: %1, Monto: %2', "Customer Name", Amount);
                Message(TextVariable);
            end;

            trigger OnPreDataItem()
            begin
                // Ejemplo: Inicializar variables o realizar configuraciones antes de procesar los datos.
                Message('Comenzando a procesar datos de clientes.');
            end;

            trigger OnPostDataItem()
            begin
                // Ejemplo: Realizar acciones después de procesar todos los datos.
                Message('Procesamiento de datos de clientes completado.');
            end;
        }
    }

    trigger OnPreReport()
    var
        TextVariable: Text;
    begin
        // Ejemplo: Configurar filtros o parámetros antes de ejecutar el reporte.
        TextVariable := 'Reporte "Customer Overview Report" iniciado.';
        Message(TextVariable);
    end;

    trigger OnPostReport()
    var
        TextVariable: Text;
    begin
        // Ejemplo: Realizar acciones después de que el reporte se haya ejecutado.
        TextVariable := 'Reporte "Customer Overview Report" finalizado.';
        Message(TextVariable);
    end;
}