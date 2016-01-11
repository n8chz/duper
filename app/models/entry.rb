class Entry < ActiveRecord::Base
  belongs_to :transaktion
  belongs_to :item
  belongs_to :account
end
