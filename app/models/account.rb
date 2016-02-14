class Account < ActiveRecord::Base
  belongs_to :account

  # Get the full pathname of an account
  def account_pathname
    account_fullname = self.name
    account_level = self
    loop do
      break if not account_level.account_id
      account_level = Account.find(account_level.account_id)
      break if account_level == self # closed loop detection TODO make it a DB constraint
      account_fullname = "#{account_level.name}|#{account_fullname}"
    end
    account_fullname
  end

  def balance
    tally = 0
    Entry.where(account_id: self.id).each do |entry|
      tally += entry.net_amt
    end
    tally
  end

  def self.columnize
    copy = Array.new(self.all)
    left_column = []
    right_column = []
    while copy.length > 0
      acct = copy.shift
      if acct.account_pathname.start_with? "assets"
        left_column.push acct
      else
        right_column.push acct
      end
    end
    [left_column, right_column].map {|column|
     column.sort {|x, y|
      x.account_pathname <=> y.account_pathname
     }
    }
  end

end
