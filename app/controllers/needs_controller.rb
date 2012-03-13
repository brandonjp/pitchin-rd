class NeedsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  
  # GET /needs
  # GET /needs.json
  def index
    @needs = Need.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @needs }
    end
  end

  # GET /needs/1
  # GET /needs/1.json
  def show
    @need = Need.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @need }
    end
  end

  # GET /needs/new
  # GET /needs/new.json
  def new
    @event = Event.find(params[:event_id])
    @need = Need.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @need }
    end
  end

  # GET /needs/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @need = @event.needs.find(params[:id])
  end

  # POST /needs
  # POST /needs.json
  def create
    @event = Event.find(params[:event_id])
    @event.needs.new(params[:need])

    respond_to do |format|
      if @event.save
        format.html { redirect_to :root, notice: 'Need was successfully created.' }
        format.json { render json: @event, status: :created, need: @need }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /needs/1
  # PUT /needs/1.json
  def update
    @event = Event.find(params[:event_id])
    @need = @event.needs.find(params[:id])

    respond_to do |format|
      if @need.update_attributes(params[:need])
        format.html { redirect_to :root, notice: 'Need was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /needs/1
  # DELETE /needs/1.json
  def destroy
    @event = Event.find(params[:event_id])
    @need = @event.needs.find(params[:id])
    @need.destroy

    respond_to do |format|
      format.html { redirect_to :root }
      format.json { head :ok }
    end
  end

end
