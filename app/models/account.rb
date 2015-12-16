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

end
