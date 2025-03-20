
# Repetitive Statements in AL Language

## Completed: 100 XP (18 minutes)

You can use repetitive statements when you want to repeat the implementation of one or more statements. The five different types of repetitive statements that you can use are:

- `for-to-do`
- `for-downto-do`
- `foreach-in-do`
- `while-do`
- `repeat-until`

### 1. For Statement

One of the most used repetitive statements is the `for` statement. If you use the `for` statement, you should already know how many times you'll repeat the implementation of statements.

In the next example, the `for` statement is used to loop five times. The variable `intCount` counts the number of times that you looped.

```al
var
    intCount: Integer;
    total: Integer;
begin
    for intCount := 1 to 5 do
        total := total + 3;
end;
```

In the following example, the number of loops is fixed by using a number (such as 5). You can also use another integer variable instead of a fixed value. Regardless, the `for` statement knows, in advance, how many times it needs to loop.

```al
var
    intCount: Integer;
    numberOfLoops: Integer;
    total: Integer;
begin
    numberOfLoops := 5;
    for intCount := 1 to numberOfLoops do
        total := total + 3;
end;
```

The `for` statement can only run one statement. If you want to run more than one statement, you need to use a compound statement with `begin` and `end`.

### 2. For Downto Statement

With the `for` statement, you're counting upward, meaning that the `for` statement increments the value of the variable. You can also decrement by using the `for downto` statement, which counts downward.

Similar to the `for` statement, which can only run one statement, the `for downto` statement only runs one statement. The next example shows the compound statement being used.

```al
var
    intCount: Integer;
    totalSales: Integer;
    numberSales: Integer;
    sales: array[5] of Integer;
begin
    GetSales(sales);

    for intCount := 5 downto 1 do begin
        totalSales := totalSales + sales[intCount];
        numberSales := numberSales + 1;
    end;
end;
```

### 3. Foreach Statement

The `foreach` statement can only be used on Enumerable collections (List of and Dictionary of), and it can't be used with arrays.

With the `foreach` statement, the variable gets the value of a certain item in the collections. Each loop is assigned the next value.

```al
var
    stringList: List of [Text[20]];
    stringItem: Text[20];
begin
    foreach stringItem in stringList do
        Message(stringItem);
end;
```

### 4. While Statement

The `while` statement first checks to see if the condition is true before you start looping. Providing that this condition stays true, it keeps running the statements within your while block.

So, it's possible that the statements won't be run at all if the condition isn't true the first time.

```al
var
    index: Integer;
    totalSales: Integer;
    sales: array[5] of Integer;
begin
    GetSales(sales);

    while totalSales < 8 do begin
        index := index + 1;
        totalSales := totalSales + sales[index];
    end;
end;
```

If you want to run multiple statements, you need to use a compound statement.

### 5. Repeat Until Statement

The `while` statement first checks for a valid condition before it starts looping, whereas the `repeat until` statement runs first and then checks for a condition. It loops until the condition is valid, meaning that `repeat until` statements are at least run once. The loop continues, if the condition isn't valid.

The `repeat until` statement is one statement, and you put your own statements within the block. This trait means that you don't have to use a compound statement if you want to run multiple statements.

```al
var
    index: Integer;
    totalSales: Integer;
    sales: array[5] of Integer;
begin
    GetSales(sales);

    repeat
        index := index + 1;
        totalSales := totalSales + sales[index];
    until totalSales >= 8;
end;
```

The `repeat until` statement is often used when you want to loop over a set of records. In the next example, you'll loop over all rows of the `MyTable` table.

```al
var
    myTable: Record MyTable;
begin
    myTable.FindSet();
    repeat
        myTable.Amount := 100;
    until myTable.Next() = 0;
end;
```

### 6. With Statement

The `with` statement is sometimes used in combination with a repetitive statement, but it can also be used as a standalone. The purpose of the `with` statement is to reduce the usage of your record variables. This structure is illustrated in the following example, where a `myTable` variable is created, and the fields within the table are all assigned a value.

```al
var
    myTable: Record MyTable;
begin
    myTable."No." := 1;
    myTable.Amount := 100;
    myTable.Credits := 10;
    myTable."Document Type" := myTable."Document Type"::Invoice;
    myTable.Reason := myTable.Reason::Return;
    myTable.Refund := 100;
end;
```

Instead of retyping the word `myTable`, you can use the `with` statement.

```al
var
    myTable: Record MyTable;
begin
    with myTable do begin
        "No." := 1;
        Amount := 100;
        Credits := 10;
        "Document Type" := "Document Type"::Invoice;
        Reason := Reason::Return;
        Refund := 100;
    end;
end;
```

### Deprecating Explicit and Implicit With Statements

The extensibility model and the AL programming language are successors to the C/AL language. And the `with` statement has up until now been supported in AL.

Using the `with` statement might make code harder to read. It can also prevent code in Business Central from being upgraded without changes to the code or even worse - upgraded, but with changed behavior.

We distinguish between two types of `with` statements; the explicit type of `with` using the keyword, and the implicit with which isn't expressed directly in code. The next sections describe each of these statements.

#### Explicit With Statements

In Business Central online, your code is recompiled when the platform and application versions are upgraded. The recompilation ensures that it's working and the recompile regenerates the runtime artifacts to match the new platform. Breaking changes without due warning aren't allowed, but the use of the `with` statement makes it impossible, as Microsoft, to make even additive changes in a completely nonbreaking way.

The following example illustrates code written using the `with` statement; referred to in this context as the explicit with statement:

```al
codeunit 50140 MyCodeunit
{
    procedure DoStuff()
    var
        Customer: Record Customer;
    begin
        with Customer do begin
            // Do some work on the Customer record.
            Name := 'Foo';

            if IsDirty() then 
                Modify();
        end;
    end; 

    local procedure IsDirty(): Boolean;
    begin
        exit(false);
    end;
}
```

#### Implicit With Statement

The implicit with is injected automatically by the compiler in certain situations. The next sections describe, how this works on codeunits and pages.

##### Codeunits

When a codeunit has the `TableNo` property set, there's an implicit with around the code inside the `OnRun` trigger.

```al
codeunit 50140 MyCodeunit
{
    TableNo = Customer;

    trigger OnRun()
    begin
        // with Rec do begin
        SetRange("No.", '10000', '20000');
        if Find() then
            repeat
            until Next() = 0;

        if IsDirty() then
            Error('Something is not clean');
        // end;
    end;

    local procedure IsDirty(): Boolean;
    begin
        exit(false);
    end;
}
```

##### Pages

Pages on tables have the same type of implicit with, but around the entire object. Everywhere inside the page object, the fields and methods from the source tables are directly available without any prefix.

```al
page 50143 ImplicitWith
{
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            field("No."; "No.") { }
            field(Name; Name)
            {
                trigger OnValidate()
                begin
                    Name := 'test';
                end;
            }
        }
    }

    trigger OnInit()
    begin
        if IsDirty() then Insert()
    end;

    local procedure IsDirty(): Boolean
    begin
        exit(Name <> '');
    end;
}
```

### Break Statement

If you want to stop the running of a loop, you can use the `break` statement.

```al
var
    intCount: Integer;
    total: Integer;
begin
    for intCount := 1 to 5 do begin
        if (total > 8) then
            break;

        total := total + 3;
    end;
end;
```

