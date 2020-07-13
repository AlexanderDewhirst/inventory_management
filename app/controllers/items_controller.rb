class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_features, only: [:new, :edit]
  before_action :set_categories, only: [:new, :edit]

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    item_feature_attributes = []

    respond_to do |format|
      if @item.save
        params['feature_ids'].each do |feature_id|
          item_features_attributes << ({ item_id: @item.id, feature_id: feature_id })
        end
        ItemFeature.first_or_create item_features_attributes
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
    item_features_attributes = []

    respond_to do |format|
      if @item.update(item_params)
        params['feature_ids'].each do |feature_id|
          item_features_attributes << ({ item_id: @item.id, feature_id: feature_id })
        end
        ItemFeature.first_or_create item_features_attributes
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

  def duplicate
    new_item = @item.duplicate
    feature_ids = @item.features.collect(&:id)
    Item.transaction do
      new_item.save!
      feature_ids.each do |feature_id|
        ItemFeature.create!(item_id: new_item.id, feature_id: feature_id)
      end
    end
    redirect_to items_url, notice: 'Item was successfully duplicated.'
  end

  private
    def set_categories
      @categories = Category.all
    end

    def set_features
      @features = Feature.all
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def item_params
      params.require(:item).permit(:category_id)
    end
end
