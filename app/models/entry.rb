class Entry < ActiveRecord::Base
  belongs_to :transaktion
  belongs_to :item
  belongs_to :account

  def net_amt
    pq = self.price*self.qty
    pq *= -1 if not self.is_debit
    pq
  end

end
