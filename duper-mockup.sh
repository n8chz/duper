#!/bin/sh 

rails create duper

cd duper

bin/rails generate scaffold Entity name:text no:integer frac:float unit:text street:text box:text city:text polsub:text postal:text nation:text phone:text email:text url:text

bin/rails generate scaffold Transaction date:datetime entity:references is_void:boolean

bin/rails generate scaffold Unit unit:text factor:float m:integer kg:integer s:integer a:integer k:integer cd:integer mol:integer

bin/rails generate scaffold Item barcode:text brand:text gendesc:text size:float unit:references

bin/rails generate scaffold Account name:text number:text account:references

bin/rails generate scaffold Entry transaction:references item:references price:integer qty:float is_debit:boolean account:references

bin/rake db:migrate

bin/rake routes

mv ../duper-mockup.sh .

# NOTE:  Columns listed as :text should have been :string.
#        This was corrected in migration db/migrate/20151215142858_text_to_string.rb

