# duper

## Note: Duper has been superseded by the much more refined ["ettal"](https://gitlab.com/n8chz/ettal)

## recordkeeping for dupermarket transactions

Essentially, a double-entry bookkeeping database, implemented with Ruby on Rails.
Special attention is given to ease of data entry of dupermarket receipts.

The "new transaction" screen can be tried out at https://guarded-everglades-94952.herokuapp.com/


TODO:

* Add code to transaktions#new controller to flip negative entries to opposite column

* Make option to delete entries, but only if more than one is displayed

* Add memo field to entries, transactions, possibly other models

* Pre-fill expense account column with "best guess" based on gendesc

* Make gendesc a typeahead/dropdown field in items/new (eventually, break off gendesc as a separate table)

* Make a "clear form" button for transaktions/new

* Export entities as vcards

