class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_features, only: [:new, :create, :edit, :update]
  before_action :set_categories, only: [:new, :create, :edit, :update]

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
    @item.price = transform_cents_to_dollars(@item.price)
  end

  # POST /items
  # POST /items.json
  def create
    params["item"]["price"] = transform_dollars_to_cents(params["item"]["price"]) if params["item"].present? && params["item"]["price"].present?
    @item = current_user.items.new(item_params)
    item_features_attributes = []
    respond_to do |format|
      if @item.save
        if params['feature_ids'].present?
          params['feature_ids'].each do |feature_id|
            item_features_attributes << ({ item_id: @item.id, feature_id: feature_id.to_i })
          end
          item_features_attributes.each do |i_f_attributes|
            ItemFeature.where(item_id: i_f_attributes[:item_id], feature_id: i_f_attributes[:feature_id]).first_or_create!
          end
        end
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
    params["item"]["price"] = transform_dollars_to_cents(params["item"]["price"]) if params["item"].present? && params["item"]["price"].present?
    item_features_attributes = []

    respond_to do |format|
      if @item.update(item_params)
        if params['feature_ids'].present?
          params['feature_ids'].each do |feature_id|
            item_features_attributes << ({ item_id: @item.id, feature_id: feature_id.to_i })
          end
          item_features_attributes.each do |i_f_attributes|
            ItemFeature.where(item_id: i_f_attributes[:item_id], feature_id: i_f_attributes[:feature_id]).first_or_create!
          end
        end
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
      params.require(:item).permit(:category_id, :name, :amount, :price)
    end

    def transform_dollars_to_cents(price)
      return (price.to_f * 100).to_i.to_s
    end

    def transform_cents_to_dollars(price)
      return sprintf('%.2f', (price.to_f / 100)).to_s
    end
end
