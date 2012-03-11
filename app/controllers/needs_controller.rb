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
        format.html { redirect_to @event, notice: 'Need was successfully created.' }
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
        format.html { redirect_to @event, notice: 'Need was successfully updated.' }
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
      format.html { redirect_to @event }
      format.json { head :ok }
    end
  end

  def unvote
    @need = Need.find(params[:id])
    current_user.unvote(@need)
    redirect_to need_url(params[:id]), :notice => "Vote has been reset."
  end

  def vote_down
    @need = Need.find(params[:id])
    current_user.vote(@need, :down)
    redirect_to need_url(params[:id]), :notice => "Vote down is successfully submitted."
  end

  def vote_up
    @need = Need.find(params[:id])
    current_user.vote(@need, :up)
    redirect_to need_url(params[:id]), :notice => "Vote up is successfully submitted."
  end
  
  def switch_status
    @need = Need.find(params[:id])
    if @need.active?
      @need.active = false
    else
      @need.active = true
    end
    @need.save
    redirect_to needs_url
  end
end
