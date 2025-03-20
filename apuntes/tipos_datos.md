# Guía de Tipos de Datos Fundamentales y Complejos en AL

## Tipos de Datos Fundamentales
Un tipo de dato fundamental no puede dividirse en subvalores y siempre contiene un solo valor.

### **Tipos Numéricos**
- **Integer**: Números enteros.
- **BigInteger**: Enteros grandes para valores numéricos extensos.
- **Decimal**: Valores numéricos con decimales.

### **Tipos de Datos Especiales**
- **Option**: Tipo enumerador basado en cero. Se almacena como un entero.
- **Char**: Representa un solo carácter almacenado como un número en código ASCII (0-255).
- **Byte**: Almacena valores en un solo byte.
- **Duration**: Representa un período de tiempo.
- **String**: Representa cadenas de caracteres.
- **Text**: Similar a *String*, pero con algunas diferencias en almacenamiento y uso.
- **Code**: Usado para almacenar códigos alfanuméricos, sensible a mayúsculas y minúsculas.
- **Boolean**: Puede almacenar *TRUE* o *FALSE*.

### **Tipos de Fecha y Hora**
- **Date**: Almacena fechas sin hora.
- **Time**: Almacena horas sin fecha.
- **DateTime**: Almacena fecha y hora combinadas.

### **Tipo de Dato Action**
El tipo de dato **Action** no está disponible como campo en una tabla, pero se usa para especificar acciones realizadas por un usuario en una página. Métodos como **PAGE.RUNMODAL** y **RUNMODAL** devuelven un valor de este tipo. Las acciones disponibles incluyen:

- **OK**
- **Cancel**
- **LookupOK**
- **LookupCancel**
- **Yes**
- **No**
- **RunObject**
- **RunSystem**

## Tipos de Datos Complejos
Los tipos de datos complejos se utilizan para trabajar con registros en tablas, imágenes (bitmaps) o archivos en disco. Estos tipos pueden almacenar múltiples valores.

Algunos de los tipos de datos complejos en AL incluyen:

- **BigText**: Almacena grandes cantidades de texto.
- **BLOB**: (Binary Large Object) almacena datos binarios.
- **CodeUnit**: Representa una unidad de código.
- **DateFormula**: Define fórmulas de fechas.
- **Dialog**: Representa cuadros de diálogo.
- **File**: Para trabajar con archivos en disco.
- **FieldRef**: Referencia a un campo de una tabla.
- **GUID**: Identificador único global.
- **InStream y OutStream**: Para la entrada y salida de datos.
- **KeyRef**: Referencia a una clave de una tabla.
- **Page**: Representa una página en Business Central.
- **Query**: Para consultas de datos.
- **Record**: Apunta a registros de una tabla específica.
- **RecordID**: Identificador de un registro.
- **RecordRef**: Referencia genérica a un registro.
- **Report**: Representa un informe en Business Central.
- **System**: Contiene funciones y valores del sistema.
- **TableFilter**: Filtro de tabla.
- **Variant**: Puede almacenar diferentes tipos de datos.
- **List & Dictionary**: Tipos de colección para almacenar listas y pares clave-valor.

### **El Tipo de Dato Record**
El tipo de dato **Record** apunta a registros de una tabla específica y puede contener múltiples valores debido a que incluye varios campos.

### **Areas de aplicacion**

Los valores comunes que puede tener ApplicationArea incluyen:

- All: El elemento está disponible en todas las áreas de la aplicación.
- Basic: El elemento está disponible en el área básica de la aplicación.
- Suite: El elemento está disponible en el área de la suite de la aplicación.
- RelationshipMgmt: El elemento está disponible en el área de gestión de relaciones.
- Dimensions: El elemento está disponible en el área de dimensiones.
- VAT: El elemento está disponible en el área de IVA.
- SalesTax: El elemento está disponible en el área de impuestos sobre las ventas.
- BasicEU: El elemento está disponible en el área básica de la UE.
- BasicNO: El elemento está disponible en el área básica de Noruega.
- Location: El elemento está disponible en el área de ubicación.
- RecordLinks: El elemento está disponible en el área de enlaces de registros.
- Notes: El elemento está disponible en el área de notas.
- Comments: El elemento está disponible en el área de comentarios.

### **Tipos de Pagina**

- Card: Una página de tarjeta que muestra los detalles de un solo registro.
- List: Una página de lista que muestra múltiples registros en una vista de tabla.
- Worksheet: Una página de hoja de trabajo que permite la entrada de datos en una vista de tabla.
- ListPart: Una parte de lista que se puede incrustar en otras páginas.
- CardPart: Una parte de tarjeta que se puede incrustar en otras páginas.
- Document: Una página de documento que muestra los detalles de un documento, como una orden de venta o una factura.
- DocumentWorksheet: Una página de hoja de trabajo de documento que permite la entrada de datos en una vista de tabla para documentos.
- RoleCenter: Una página de centro de roles que proporciona una vista general de las tareas y actividades del usuario.
- ConfirmationDialog: Una página de diálogo de confirmación que se utiliza para confirmar acciones del usuario.
- NavigatePage: Una página de navegación que se utiliza para mostrar y seleccionar registros relacionados.
- StandardDialog: Una página de diálogo estándar que se utiliza para mostrar mensajes y recopilar entradas del usuario.
- API: Una página de API que se utiliza para exponer datos a través de servicios web.
- Report: Una página de informe que se utiliza para mostrar informes.
- HeadlinePart: Una parte de encabezado que se puede incrustar en otras páginas para mostrar información destacada.