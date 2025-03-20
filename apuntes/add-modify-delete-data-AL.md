# Add, Modify, or Delete Data with AL

This guide covers how to modify data in the database using AL code through various statements:
- Insert
- Modify and ModifyAll
- Delete and DeleteAll

## Insert Statement

The `Insert` statement adds new records to the database. Before inserting data, you need to set values for each field you want to store.

```al
var
    customer: Record Customer;
begin
    customer.Init();
    customer."No." := '4711';
    customer.Name := 'John Doe';
    customer.Insert(true);
```

### Important Notes on Insert:
- The `Insert` command accepts a `RunTrigger` Boolean parameter (default is **false**)
- If `RunTrigger` is **false**, the `OnInsert` trigger at table level will not execute
- Set `RunTrigger` to **true** if you want the `OnInsert` trigger to run
- This behavior exists for performance reasons
- Similar to field value assignment, which doesn't run the `OnValidate` trigger by default
- `OnBeforeInsert` or `OnAfterInsert` events are always run, regardless of the `RunTrigger` parameter

## Modify and ModifyAll Statements

To change values of an existing record, you first need to retrieve the record, update the values, and then use the `Modify` function to store changes in the database.

```al
customer.Get('4711');
customer.Name := 'Richard Roe';
customer.Modify();
```

### Key Points on Modify:
- Like `Insert`, you need to provide a **true** value to run the `OnModify` trigger at table level
- The `Modify` function doesn't ask for confirmation; changes are applied without warning

### ModifyAll Statement

To update multiple records simultaneously, use the `ModifyAll` function.

```al
ModifyAll(Field, NewValue, [RunTrigger])
```

Example - changing all records with Salesperson Code 'PS' to 'JR':
```al
customer.SetRange("Salesperson Code", 'PS');
customer.ModifyAll("Salesperson Code", 'JR');
```

## Delete and DeleteAll Statements

Similar to `Modify`, you need to retrieve a record before deleting it. The `Delete` and `DeleteAll` functions also accept a `RunTrigger` parameter.

```al
customer.Get('4711');
customer.Delete(true);
```

### DeleteAll Statement

To remove multiple records at once, use the `DeleteAll` function:

```al
customer.SetRange("Salesperson Code", 'PS');
customer.DeleteAll();
```

### Important Note on Deletion:
- The `Delete` and `DeleteAll` functions don't ask for confirmation; deletions are completed without warning
