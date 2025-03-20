# Use Different Field Functions in AL

When working with database data in AL, several important field-related functions are available:

- CalcFields
- CalcSums
- FieldError
- Init
- TestField
- Validate

## CalcFields and SetAutoCalcfields Statements

### CalcFields
When retrieving FlowFields in AL code, their value is always zero because the calculation formula isn't automatically executed. Unlike pages where FlowFields are automatically calculated, in AL code you must use the `CalcFields` function to specify which FlowFields need to be calculated.

```al
customer.SetRange("Date Filter", 0D, Today());

// Using CALCFIELDS
if customer.FindSet() then
    repeat
        customer.CalcFields(Balance, "Net Change");
        // Do some additional processing
    until customer.Next() = 0;
```

**Note:** The FlowFields are only calculated within their scope. Outside the repeat-until statement, they are no longer calculated.

### SetAutoCalcFields
If you want to always calculate certain FlowFields within a function scope, use the `SetAutoCalcFields` function:

```al
// Using SETAUTOCALCFIELDS
customer.SetAutoCalcFields(Balance, "Net Change");
if customer.FindSet() then
    repeat
        // Do some additional processing
    until customer.Next() = 0;
```

## CalcSums Statement

The `CalcSums` function calculates a total for a specific field based on the filters of the dataset.

```al
salesInvoiceHeader.SetCurrentKey("Bill-to Customer No.");
salesInvoiceHeader.SetRange("Bill-to Customer No.", '10000', '50000');
salesInvoiceHeader.SetRange("Document Date", 0D, Today());
salesInvoiceHeader.CalcSums(Amount);

Message('The total is %1', salesInvoiceHeader.Amount);
```

## FieldError Statement

The `FieldError` function stops code execution, causes a run-time error, and creates an error message for a specific field. The field displays a red border, indicating that an error has occurred with the value of this field.

```al
if item."Unit Price" < 10 then
    item.FieldError("Unit Price", 'must be greater than 10');
```

## Init Statement

The `Init` command initializes all fields on a record to their default values (0 for numeric data types, empty string for text, etc.). If you specified an `InitValue` on the field in the table, the `Init` function initializes your field with that value instead of the default value.

```al
customer.Init();
customer.Name := 'John Doe';
customer."E-Mail" := 'john.doe@contoso.com';
customer.Insert(true);
```

## TestField Statement

The `TestField` function checks if a field has a value or if it's blank. If the field is empty, it generates a run-time error.

```al
customer.TestField("Salesperson Code");
```

You can also use `TestField` to test whether a field contains a specific value. If it doesn't, the field generates an error:

```al
customer."Salesperson Code" := 'DK';
customer.TestField("Salesperson Code", 'ZX');
```

## Validate Statement

When you assign a value to a field, the `OnValidate` trigger of that field isn't run. If you want to run the `OnValidate` trigger, use the `Validate` function:

```al
Customer."Phone No." := '1234567891234'
customer.Validate("Phone No.");
```

You can also use the `Validate` function to assign a value and run the `OnValidate` trigger in one step:

```al
customer.Validate("Phone No.", '1234567891234');
```
