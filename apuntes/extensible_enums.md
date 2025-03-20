### ✨ Explicación del Uso de `Extensible Enums` con Interfaces en AL (Business Central)

En **Business Central**, los **enums extensibles** (`Extensible = true`) permiten asociar **implementaciones de interfaces** a cada valor del `enum`. De esta forma, se puede seleccionar dinámicamente la lógica a ejecutar, evitando estructuras de control como `CASE` o `IF`.

---

## ✨ 1. Definir la Interfaz `IPriceCalculation`

Esta interfaz define el método que deben implementar todas las versiones del cálculo de precios.

```al
interface IPriceCalculation
{
    procedure ApplyDiscount(var Price: Decimal);
}
```

**Propósito:**
- Establece un contrato para todas las implementaciones.
- Garantiza que todas las clases que calculan precios tengan `ApplyDiscount()`.

---

## ✨ 2. Crear las Implementaciones del Cálculo de Precio (`v15` y `v16`)

Definimos dos `codeunit`, cada uno con su propia lógica de cálculo.

```al
codeunit 50101 PriceCalculationV15 implements IPriceCalculation
{
    procedure ApplyDiscount(var Price: Decimal)
    begin
        Price := Price * 0.9; // Aplica un 10% de descuento
        Message('Usando PriceCalculation v15: ' + Format(Price));
    end;
}

codeunit 50102 PriceCalculationV16 implements IPriceCalculation
{
    procedure ApplyDiscount(var Price: Decimal)
    begin
        Price := Price * 0.8; // Aplica un 20% de descuento
        Message('Usando PriceCalculation v16: ' + Format(Price));
    end;
}
```

**Diferencias entre implementaciones**
- `PriceCalculationV15` aplica un **10%** de descuento.
- `PriceCalculationV16` aplica un **20%** de descuento.

---

## ✨ 3. Crear el `Enum` Extensible con Implementaciones de `IPriceCalculation`

```al
enum 50110 PriceCalculationEnum implements IPriceCalculation
{
    Extensible = true;
    DefaultImplementation = IPriceCalculation = PriceCalculationV15; // Valor por defecto

    value(0; V15)
    {
        Implementation = IPriceCalculation = PriceCalculationV15;
    }
    value(1; V16)
    {
        Implementation = IPriceCalculation = PriceCalculationV16;
    }
}
```

**Explicación:**
- `Extensible = true;` → Permite que otros módulos extiendan este `enum`.
- `DefaultImplementation` → Si no se especifica un valor, usa `PriceCalculationV15`.
- `value(0; V15)` → Asigna `PriceCalculationV15` al valor `V15`.
- `value(1; V16)` → Asigna `PriceCalculationV16` al valor `V16`.

---

## ✨ 4. Uso del Enum para Seleccionar la Implementación

```al
procedure CalculateFinalPrice(CalcMethod: PriceCalculationEnum; var Price: Decimal)
var
    PriceCalc: Interface IPriceCalculation;
begin
    PriceCalc := CalcMethod; // Asigna la implementación según el enum seleccionado
    PriceCalc.ApplyDiscount(Price);
end;
```

**Funcionamiento**
1. Recibe un `enum` `PriceCalculationEnum`, que determina qué implementación usar.
2. Lo asigna a una variable de tipo `IPriceCalculation`.
3. Llama a `ApplyDiscount(Price)`, ejecutando la implementación correspondiente.

---

## ✨ 5. Llamada a la Función con Diferentes Métodos de Cálculo

```al
var
    Price: Decimal;
begin
    Price := 100;
    CalculateFinalPrice(PriceCalculationEnum::V15, Price); // "Usando PriceCalculation v15: 90"

    Price := 100;
    CalculateFinalPrice(PriceCalculationEnum::V16, Price); // "Usando PriceCalculation v16: 80"
end;
```

**Resultados Esperados:**
- `V15` usa `PriceCalculationV15`, aplica un 10% de descuento → **Precio final: 90**.
- `V16` usa `PriceCalculationV16`, aplica un 20% de descuento → **Precio final: 80**.

---

## 📈 Conclusión
| **Característica** | **Descripción** |
|-------------------|----------------|
| **Enums Extensibles** | Permiten asignar implementaciones específicas según el valor del `enum`. |
| **Evita `CASE` y `IF`** | Hace el código más modular y mantenible. |
| **Facilidad de Extensión** | Se pueden agregar nuevas versiones de cálculo sin modificar el código existente. |

Este patrón es **ideal** para **reemplazar o actualizar lógicas** sin afectar el código base, por ejemplo, **actualizar cálculos de precios en futuras versiones** sin modificar el código que los usa. 🚀

