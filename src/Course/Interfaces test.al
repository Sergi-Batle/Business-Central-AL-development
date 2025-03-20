page 50132 MyAddress
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
            }
        }
    }

    actions
    { 
        area(Processing)
        {
            action(WhatsTheAddress)
            {
                ApplicationArea = All;
                Caption = 'What''s the Address?';
                ToolTip = 'Select the address.';
                Image = Addresses;

                trigger OnAction()
                var
                    iAddressProvider: Interface IAddressProvider;

                    
                begin
                    AddressproviderFactory(iAddressProvider);
                    Message(iAddressProvider.GetAddress());

          
                end;
            }

            action(SendToHome)
            {
                ApplicationArea = All;
                Image = Home;
                Caption = 'Send to Home.';
                ToolTip = 'Set the interface implementation to Home.';
                trigger OnAction()
                begin
                    sendTo := sendTo::Private
                end;
            }

            action(SendToWork)
            {
                Image = WorkCenter;
                Caption = 'Send to Work.';
                ToolTip = 'Set the interface implementation to Work.';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    sendTo := sendTo::Company
                end;
            }
        }
    }

    local procedure AddressproviderFactory(var iAddressProvider: Interface IAddressProvider)
    var
        CompanyAddressProvider: Codeunit CompanyAddressProvider;
        PrivateAddressProvider: Codeunit PrivateAddressProvider;
    begin

        if sendTo = sendTo::Company then
            iAddressProvider := CompanyAddressProvider;

        if sendTo = sendTo::Private then
            iAddressProvider := PrivateAddressProvider;

    end;

    var
        sendTo: enum SendTo;
}

enum 50130 SendTo
{
    Extensible = true;

    value(0; Company)
    {
    }

    value(1; Private)
    {
    }
}

interface IAddressProvider
{
    procedure GetAddress(): Text;
}

codeunit 50140 PrivateAddressProvider implements IAddressProvider
{
    procedure GetAddress(): Text;
    begin
        exit('My Home address \ Denmark 2800')
    end;
}

codeunit 50141 CompanyAddressProvider implements IAddressProvider
{
    procedure GetAddress(): Text;
    begin
        exit('Company address \ Denmark 2800')
    end;
}