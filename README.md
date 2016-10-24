# duper

===recordkeeping for dupermarket transactions===

Essentially, a double-entry bookkeeping database, implemented with Ruby on Rails.
Special attention is given to ease of data entry of dupermarket receipts.

The "new transaction" screen can be tried out at https://guarded-everglades-94952.herokuapp.com/


TODO:

* Fix bug in entries#index:  `Showing /var/www/ruby/rails/duper/app/views/entries/index.html.erb where line #21 raised: comparison of ActiveSupport::TimeWithZone with nil failed`

* Add code to transaktions#new controller to flip negative entries to opposite column

* Make option to delete entries, but only if more than one is displayed

* Add memo field to entries, transactions, possibly other models

* Pre-fill expense account column with "best guess" based on gendesc

* Make gendesc a typeahead/dropdown field in items/new (eventually, break off gendesc as a separate table)

* Make a "clear form" button for transaktions/new

* Export entities as vcards

