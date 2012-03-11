class ItemsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  
  # GET /items
  # GET /items.json
  def index
    @items = Item.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, item: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @events = Event.where(item_id: params[:id])
    @events.each.destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :ok }
    end
  end

  def unvote
    @item = Item.find(params[:id])
    current_user.unvote(@item)
    redirect_to item_url(params[:id]), :notice => "Vote has been reset."
  end

  def vote_down
    @item = Item.find(params[:id])
    current_user.vote(@item, :down)
    redirect_to item_url(params[:id]), :notice => "Vote down is successfully submitted."
  end

  def vote_up
    @item = Item.find(params[:id])
    current_user.vote(@item, :up)
    redirect_to item_url(params[:id]), :notice => "Vote up is successfully submitted."
  end
  
  def switch_status
    @item = Item.find(params[:id])
    if @item.active?
      @item.active = false
    else
      @item.active = true
    end
    @item.save
    redirect_to items_url
  end
end
