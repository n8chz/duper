class Entry < ActiveRecord::Base
  belongs_to :transaktion
  belongs_to :item
  belongs_to :account

  def net_amt
    if self.price and self.qty
      pq = self.price*self.qty/100
      pq *= -1 if not self.is_debit
      pq
    else
      0
    end
  end

  def entry_date
    Transaktion.find(self.transaktion_id).date
  end

end
