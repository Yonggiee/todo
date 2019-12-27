class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy, :complete, :undo_complete]

  def index
    if params[:search] == "Show All" || params[:search] == ""
      redirect_to root_path
    else 
      @items = Item.search(params[:search], params[:type])  
      @completed = @items.select { |item| item.completed }    
      @onGoing = @items.select { |item| !item.completed && !(item.expiryDate < Date.today) }  
      @expired = @items.select { |item| !item.completed && (item.expiryDate < Date.today) }                    
    end
    @item = Item.new                                                      
    @categories = Item.distinct.pluck(:category).sort()
  end                                                                            

  def new
    @item = Item.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @item = Item.new(item_params)
    @item.completed = false
    if @item.save
      redirect_to root_path
    else
      render 'new'
    end
  end 

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      @item.created_at = DateTime.now
      @item.save
      redirect_to item_path(@item)
    else
      render 'edit'
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def complete
    @item.update_attribute(:completed, true)
    redirect_back(fallback_location: root_path)
  end

  def undo_complete
    @item.update_attribute(:completed, false)
    redirect_back(fallback_location: root_path)
  end

  def calendar
    @items = Item.all
    @items_by_date = @items.group_by(&:expiryDate)
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private

    def item_params
      params.require(:item).permit(:title, :description, :category, :expiryDate)
    end

    def find_item
      @item = Item.find(params[:id])
    end

end
