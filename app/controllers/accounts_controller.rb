class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all
    genericResponse @accounts
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = Account.new
    @accounts = Account.all # line added by Lori
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        if params["date"] && params["init"]
          # identify opening balances account
          openingBalancesAccount = Account.find_by name: "opening balances"
          # create transaction which initializes account balance:
          transaktion = {}
          transaktion["date"] = params["date"]
          transaktion["is_void"] = false
          tr = Transaktion.new(transaktion)
          tr.save
          # create two entries for account-initializing transaction:
          debit = {}
          debit["account_id"] = @account.id
          debit["transaktion_id"] = tr.id
          debit["price"] = params["init"]
          debit["qty"] = 1
          debit["is_debit"] = true
          Entry.new(debit).save
          credit = debit
          credit["account_id"] = openingBalancesAccount.id
          credit["is_debit"] = false
          Entry.new(credit).save
        end
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json {
         render json: {id: @account.id, friendlyName: friendlyName(@account), input: params[:input]}
        }
      else
        # format.html { render :new }
        # format.json { render json: @account.errors, status: :unprocessable_entity }
        render "new"
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name, :number, :account_id)
    end


end
