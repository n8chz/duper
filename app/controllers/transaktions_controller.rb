class TransaktionsController < ApplicationController
  before_action :set_transaktion, only: [:show, :edit, :update, :destroy]

  # GET /transaktions
  # GET /transaktions.json
  def index
    @transaktions = Transaktion.all
  end

  # GET /transaktions/1
  # GET /transaktions/1.json
  def show
  end

  # GET /transaktions/new
  def new
    @transaktion = Transaktion.new
    # Make data available for option pulldowns:
    # TODO At some point (when massively many items are on file)
    # we will do this w. AJAX
    @entities = Entity.all
    @items = Item.all
    @units = Unit.all
    @accounts = Account.all
  end

  # GET /transaktions/1/edit
  def edit
  end

  # POST /transaktions
  # POST /transaktions.json
  def create
    params.permit!
    @transaktion = Transaktion.new(params["transaktion"])
    @transaktion.save # see http://stackoverflow.com/a/2618902/948073 
    params["entry"].keys.each do |index|
      entry = params["entry"][index]
      entry["qty"] = 1 if not entry["qty"]
      # price is an integer field, measured in pennies...
      is_debit = (index.to_i%2 != 0)
      entry["is_debit"] = is_debit
      price = (100.0*(entry["price"].to_f)+0.5).to_s
      entry["price"] = price
      entry["transaktion_id"] = @transaktion.id
      Entry.new(entry).save
    end

    respond_to do |format|
      if @transaktion.save
        format.html { redirect_to @transaktion, notice: 'Transaktion was successfully created.' }
        format.json { render :show, status: :created, location: @transaktion }
      else
        format.html { render :new }
        format.json { render json: @transaktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transaktions/1
  # PATCH/PUT /transaktions/1.json
  def update
    respond_to do |format|
      if @transaktion.update(transaktion_params)
        format.html { redirect_to @transaktion, notice: 'Transaktion was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaktion }
      else
        format.html { render :edit }
        format.json { render json: @transaktion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transaktions/1
  # DELETE /transaktions/1.json
  def destroy
    @transaktion.destroy
    respond_to do |format|
      format.html { redirect_to transaktions_url, notice: 'Transaktion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaktion
      @transaktion = Transaktion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaktion_params
      params.require(:transaktion).permit(:date, :entity_id, :is_void)
    end
end
