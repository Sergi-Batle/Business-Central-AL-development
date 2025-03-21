# Exercise - Custom Functions for Credit Limit Management

## Objective
Customize the "Customer Card" page by adding an action that adjusts a customer's credit limit based on their sales history or resets it to zero if there are no transactions.

## Requirements

- The customer's credit limit cannot exceed 50% of total sales revenue from the last 12 months
- The credit limit must be rounded to the nearest 10,000
- If the credit limit is rounded, the application must notify the user
- If the new credit limit does not differ from the previous one, the application must notify the user
- If the customer has no sales history in the last 12 months, the credit limit must be reset to zero
- The function that sets the credit limit must be available for other objects
- The "Customer Card" page must include an action that calls the function
- If the function is called from the page action and would increase the credit limit, the function must ask for user confirmation before updating

## Tasks

1. Create a new extension
2. Create a table extension
3. Create a page extension

## Step-by-Step Implementation

### 1. Setup Project

1. Start Visual Studio Code
2. Create a new AL extension project:
   - Open Command Palette (Ctrl+Shift+P)
   - Enter `AL: Go!`
   - Accept the suggested path but change the name to `CreditLimit`
   - Select `latest` as the target platform
   - Select `Microsoft cloud sandbox` as the development endpoint
3. Download application symbols:
   - Open Command Palette (Ctrl+Shift+P)
   - Enter `AL: Download symbols`
   - Provide Microsoft 365/Microsoft Entra ID credentials
4. Configure project:
   - Open `app.json` and change:
     - `name` to "Credit Limit"
     - `publisher` to "Cronus International Ltd"
     - `idRanges` from 50400 to 50450
   - Delete the `HelloWorld.al` file
   - Add a folder named `src`

### 2. Create Table Extension

Create a file named `Customer.TableExt.al` in the `src` folder:

```al
tableextension 50400 Customer extends Customer
{
    procedure UpdateCreditLimit(var NewCreditLimit: Decimal)
    begin
        NewCreditLimit := Round(NewCreditLimit, 10000);
        Rec.Validate("Credit Limit (LCY)", NewCreditLimit);
        Rec.Modify();
    end;

    procedure CalculateCreditLimit(): Decimal
    var
        Customer: Record Customer;
    begin
        Customer := Rec;
        Customer.SetRange("Date Filter", CalcDate('<-12M>', WorkDate()), WorkDate());
        Customer.CalcFields("Sales (LCY)", "Balance (LCY)");
        exit(Round(Customer."Sales (LCY)" * 0.5));
    end;
}
```

### 3. Create Page Extension

Create a file named `CustomerCard.PageExt.al` in the `src` folder:

```al
pageextension 50400 CustomerCard extends "Customer Card"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addafter("F&unctions")
        {
            action(UpdateCreditLimit)
            {
                ApplicationArea = All;
                Caption = 'Update Credit Limit';
                Image = CalculateCost;
                ToolTip = 'Update Credit Limit';

                trigger OnAction()
                begin
                    CallUpdateCreditLimit();
                end;
            }
        }
    }
    var
        AreYouSureQst: Label 'Are you sure that you want to set the %1 to %2?',  Comment = '%1 is Credit Limit caption and %2 is the new Credit Limit value.' ;
        CreditLimitRoundedTxt: Label 'The credit limit was rounded to %1 to comply with company policies.',  Comment = '%1 is new Credit Limit value';
        CreditLimitUpToDateTxt: Label 'The credit limit is up to date.';

    local procedure CallUpdateCreditLimit()
    var
        CreditLimitCalculated, CreditLimitActual : Decimal;
    begin
        CreditLimitCalculated := Rec.CalculateCreditLimit();
        if CreditLimitCalculated = Rec."Credit Limit (LCY)" then begin
            Message(CreditLimitUpToDateTxt);
            exit;
        end;

        if GuiAllowed() then
            if not Confirm(AreYouSureQst, false, Rec.FieldCaption("Credit Limit (LCY)"), CreditLimitCalculated) then
                exit;

        CreditLimitActual := CreditLimitCalculated;
        Rec.UpdateCreditLimit(CreditLimitActual);
        if CreditLimitActual <> CreditLimitCalculated then
            Message(CreditLimitRoundedTxt, CreditLimitActual);
    end;
}
```

### 4. Enhance for Zero Credit Limit

**Note:** The final code should be modified to handle the case where a customer has no sales history in the last 12 months, in which case the credit limit should be reset to zero.

### 5. Deploy and Test

1. Configure the launch settings:
   - Open `launch.json` in the `.vscode` folder
   - Set `startupObjectId` to 22
   - Set `startupObjectType` to Page
2. Publish the extension:
   - Open Command Palette (Ctrl+Shift+P)
   - Enter `AL: Publish` (or press F5)
3. Test the functionality:
   - Verify that Microsoft Dynamics 365 Business Central launches with the Customer List page
   - Open any customer card
   - Find and test the "Update Credit Limit" action in the Functions menu

## Key Code Explanations

### CalculateCreditLimit Function
```al
Customer := Rec;
Customer.SetRange("Date Filter", CalcDate('<-12M>', WorkDate()), WorkDate());
Customer.CalcFields("Sales (LCY)", "Balance (LCY)");
exit(Round(Customer."Sales (LCY)" * 0.5));
```
This implements the requirement: "The customer's credit limit cannot exceed 50% of total sales revenue from the last 12 months."

### UpdateCreditLimit Function
```al
NewCreditLimit := Round(NewCreditLimit, 10000);
Rec.Validate("Credit Limit (LCY)", NewCreditLimit);
Rec.Modify();
```
This implements the requirement: "The credit limit must be rounded to the nearest 10,000."

### CallUpdateCreditLimit Procedure
Handles the user interaction, confirmation, and notifications according to the requirements.
