codeunit 50200 "BSCL Subscriber Store"
{
    var
        OnBeforeOnDeleteBookErr: Label 'You are not allowed to delete %1 %2 because it is liked by one or mor customer';

    [EventSubscriber(ObjectType::Table, Database::"BSB Book", OnBeforeOnDelete, '', false, false)]
    local procedure OnBeforeOnDelete(var Rec: Record "BSB Book"; var IsHandled: Boolean);
    var
        Customer: Record Customer;
    begin
        if IsHandled then
            exit;

        Customer.SetCurrentKey("BSB Favorite Book No.");
        Customer.SetRange("BSB Favorite Book No.", Rec."No.");
        if not Customer.IsEmpty then
            Error(OnBeforeOnDeleteBookErr, Rec.TableCaption, rec."No.");
        IsHandled := true;
    end;

    // [EventSubscriber(ObjectType::Table, Database::Customer, OnAfterValidateEvent, "BSB Favorite Book No.", false, false)]
    // local procedure CustOnAfterValidateBSBFavBookNo(var Rec: Record Customer; var xRec: Record Customer)
    // begin
    //     if Rec."BSB Favorite Book No." <> xRec."BSB Favorite Book No." then
    //         Rec.Modify();
    // end;

}