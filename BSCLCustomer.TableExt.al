tableextension 50201 "BSCL Customer" extends Customer
{
    fields
    {
        modify("BSB Favorite Book No.")
        {
            trigger OnAfterValidate()
            begin
                if "BSB Favorite Book No." <> xRec."BSB Favorite Book No." then
                    Modify();
            end;
        }
    }
    procedure ShowFavoriteBook()
    var
        BSBBook: Record "BSB Book";
    begin
        BSBBook.ShowCard("BSB Favorite Book No.");
    end;
}