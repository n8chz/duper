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

  def self.chartize
    self.all.sort {|x, y|
      # account_pathname will be applied twice to all but first and last
      # TODO: find a way to iron out that inefficiency/redundancy?
      xpath = x.account_pathname
      ypath = y.account_pathname
      [xpath, ypath].each {|path| path = "c"<< path if path.start_with? "liabilities"}
      puts "#{xpath} #{ypath}"
      xpath <=> ypath
    }
  end

  def self.columnize
    right_column = Array.new(self.all)
    left_column = []
    right_column.each do |account|
      if account.account_pathname.start_with? "assets|"
        left_column.push right_column.shift
      end
    end
    [left_column, right_column].map {|column| column.sort}
  end

end
