class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    @units = Unit.all

    # see http://stackoverflow.com/a/3222639/948073 
    respond_to do |format|
     format.json {
      puts "foo"
      descriptions = @items.map { |item|
       units = @units.select { |u|
        u.id == item.unit_id
       }
       unit = ""
       unit = units[0].unit if units.length > 0
       puts unit
       {label: "#{item.brand} #{item.gendesc}, #{item.size} #{unit} #{item.barcode}", value: "item.id"}
      }
      if params[:term]
       descriptions.select! { |desc| desc[:label].index(params[:term]) }
      end
      # { render :json =>  descriptions.to_json }
      render json: descriptions.to_json
     }
    end
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
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
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
