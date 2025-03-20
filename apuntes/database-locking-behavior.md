# Control Database Locking Behavior

## Introduction

By default, Business Central's runtime automatically determines the isolation levels used when querying the database. However, AL developers can explicitly control the database isolation level on individual record instances.

The isolation level on a transaction determines how isolated it is from other transactions to prevent problems in concurrent situations. On the record level, the isolation level improves data integrity and stability when multiple transactions read the same record by taking locks and preventing issues like reads of uncommitted data or unwanted modifications.

## Database Locking and Performance

Database locking can significantly impact performance. When AL code takes fewer locks, it increases system performance for end users. By using record instance isolation level, you can improve performance by limiting database locks to only what's necessary.

## Current Behavior

Business Central's runtime automatically determines isolation levels for database queries. A transaction's isolation level can be heightened either:
- Implicitly by writes on a record
- Explicitly via a `LockTable` method call (on a per-table basis)

A heightened isolation level persists for the entire transaction, affecting all subsequent code execution whether required or not.

Example of current behavior with SQL isolation level hints annotated:

```al
local procedure CurrentBehavior()
var
    cust: Record Customer;
    otherCust: Record Customer;
    curr: Record Currency;
begin
    cust.FindFirst(); // READUNCOMMITTED

    // Heighten isolation level for Customer table.
    cust.LockTable();
    cust.FindLast(); // UPDLOCK

    // Also impacts other instances of same table.
    otherCust.FindSet(); // UPDLOCK

    // But does not impact other tables.
    curr.Find(); // READUNCOMMITTED
end;
```

## Record Instance Isolation Level

With record instance isolation level, you can explicitly select the isolation level for reads on a record instance. This overrides the transaction's isolation level for a given table, allowing you to both heighten and lower the isolation level. The effect is localized to the record instance instead of lasting for the entire transaction.

Example using record instance isolation level:

```al
local procedure UsingReadIsolation()
var
    cust: Record Customer;
    otherCust: Record Customer;
    curr: Record Currency;
begin
    cust.FindFirst(); // READUNCOMMITTED

    // Heighten isolation level for Customer table.
    cust.LockTable();

    // Explicitly select another isolation level than the transaction's.
    otherCust.ReadIsolation := IsolationLevel::ReadUncommitted;

    otherCust.FindSet(); // READUNCOMMITED
end;
```

## Isolation Level Options

The `IsolationLevel` option type provides these values:

- **Default**: Follows the transaction's state (same as not using read isolation)
- **ReadUncommitted**: 
  - Allows dirty reads (can read rows modified but not committed by other transactions)
  - Takes no locks and ignores locks from other transactions
- **ReadCommitted**: 
  - Allows reads on committed data only
  - Cannot read uncommitted changes from other transactions
  - Doesn't guarantee row consistency throughout the entire transaction
- **RepeatableRead**: 
  - Ensures all reads are stable by holding shared locks for the transaction lifetime
  - Cannot read uncommitted data from other transactions
  - Prevents other transactions from modifying read data until current transaction completes
- **UpdLock**: 
  - Reads for update, preventing others from reading with the same intent

## Practical Examples

### Example 1: Getting the next entry number
```al
// Gets the next "Entry No." and locks just last row.
// Without causing the rest of transaction to begin taking locks.
local procedure GetNextEntryNo(): Integer
var
    GLEntry: Record "G/L Entry";
begin
    GLEntry.ReadIsolation := IsolationLevel::UpdLock;
    GLEntry.FindLast();
    exit(GLEntry."Entry No." + 1)
end;
```

### Example 2: Getting an estimated record count
```al
local procedure GetEstimatedCount(tableno: Integer) : Integer
var
    rref: RecordRef;
begin
    rref.Open(tableno);
    rref.ReadIsolation := IsolationLevel::ReadUncommitted;
    exit(rref.Count);
end;
```

## FlowFields and Isolation Level

- With default transaction state: The isolation level is determined by the target table of the FlowField's formula, not the source table's state
- With record instance isolation level: The specified isolation level is used regardless of the target table

Example with FlowFields:

```al
local procedure Foo()
var
    purchLine: Record "Purchase Line";
    curr: Record Currency;
begin
    curr.FindFirst();

    curr.CalcFields(curr."Vendor Outstanding Orders"); // READUNCOMMITED

    purchLine.LockTable();

    curr.CalcFields(curr."Vendor Outstanding Orders"); // UPDLOCK

    curr.ReadIsolation := IsolationLevel::ReadUncommitted;

    curr.CalcFields(curr."Vendor Outstanding Orders"); // READUNCOMMITTED
end;
```
