# Sort and Filter Data in Code

## Introduction
This guide covers how to sort and filter data in AL code when working with Business Central databases. By default, data is sorted by the primary key, but this behavior can be modified.

## Sorting Data

### SetCurrentKey Function
Use `SetCurrentKey` to specify the field(s) to sort by before running `Find` or `FindSet` statements.

```al
var
    customer: Record Customer;
begin
    customer.SetCurrentKey(City);

    customer.FindFirst();
    Message('%1', customer);
```

## Filtering Data
Filtering reduces the amount of data retrieved from the database, improving performance. There are two main methods:

### SetRange Function
Used to specify a start and end value for a specific field.

Syntax:
```al
SetRange(Field, [FromValue], [ToValue])
```

Example:
```al
customer.SetRange("No.", '10000', '40000');
customer.FindSet();
repeat
    Message('%1', customer);
until customer.Next() = 0;
```

Special cases:
- Omitting `ToValue`: Searches for records where the field equals `FromValue`
- Omitting both parameters: Removes the filter on the specified field
  ```al
  customer.SetRange("No."); // Removes filter on "No." field
  ```

### SetFilter Function
More flexible than `SetRange`, allows complex filtering conditions.

Syntax:
```al
SetFilter(Field, String, [Value1], [Value2], …)
```

Operators available:
- `>` (greater than)
- `<` (less than)
- `<>` (not equal)
- `<=` (less than or equal)
- `>=` (greater than or equal)
- `*` (wildcard)
- `..` (range)
- `&` (and)
- `|` (or)

Examples:
```al
// Filter for customers with number greater than 10000 and not equal to 20000
customer.SetFilter("No.", '> 10000 & <> 20000');

// Using placeholders
value1 := '10000';
value2 := '20000';
customer.SetFilter("No.", '>%1&<>%2', value1, value2);
```

## Multiple Field Filtering
Chain multiple `SetRange` and/or `SetFilter` statements for multi-field filtering.

```al
customer.SetRange("No.", '10000', '90000');
customer.SetFilter(City, '@B*');          // Case-insensitive search for cities starting with 'B'
customer.SetFilter("Country/Region Code", 'B*');  // Case-sensitive search for countries starting with 'B'
customer.FindSet();
repeat
    Message('%1', customer);
until customer.Next() = 0;
```

### OR Conditions
Use the pipe symbol `|` for OR conditions:

```al
customer.SetFilter("No.", '10000|20000|30000');
```

## Checking for Matching Records
Use the `IsEmpty` function to check if any records match your filters:

```al
DocumentNo := '10000';

SalesLine.SetRange("Document No.", DocumentNo);
if (SalesLine.IsEmpty()) then
    Message('No sales line records found for document %1', DocumentNo);
```
