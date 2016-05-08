class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    # h/t http://stackoverflow.com/a/3222639/948073
    @items = Item.all.reverse
    @units = Unit.all
    genericResponse @items
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @units = Unit.all
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    puts "request.referrer: " << request.referrer
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        # format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.html { redirect_to new_item_url }
        # format.json { render :show, status: :created, location: @item }
        format.json {
         render json: {id: @item.id, friendlyName: friendlyName(@item), input: params[:input]}
        }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:barcode, :brand, :gendesc, :size, :unit_id)
    end
end
