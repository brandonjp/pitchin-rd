class EventsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, event: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @events = Event.where(event_id: params[:id])
    @events.each.destroy
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end

  def unvote
    @event = Event.find(params[:id])
    current_user.unvote(@event)
    redirect_to event_url(params[:id]), :notice => "Vote has been reset."
  end

  def vote_down
    @event = Event.find(params[:id])
    current_user.vote(@event, :down)
    redirect_to event_url(params[:id]), :notice => "Vote down is successfully submitted."
  end

  def vote_up
    @event = Event.find(params[:id])
    current_user.vote(@event, :up)
    redirect_to event_url(params[:id]), :notice => "Vote up is successfully submitted."
  end
  
  def switch_status
    @event = Event.find(params[:id])
    if @event.active?
      @event.active = false
    else
      @event.active = true
    end
    @event.save
    redirect_to events_url
  end
end
