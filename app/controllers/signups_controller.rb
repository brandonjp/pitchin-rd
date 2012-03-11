class SignupsController < ApplicationController
  
#  before_filter :authenticate_user!, :except => [:show, :index]
  
  # GET /signups
  # GET /signups.json
  def index
    @signups = Signup.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @signups }
    end
  end

  # GET /signups/1
  # GET /signups/1.json
  def show
    @signup = Signup.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @signup }
    end
  end

  # GET /signups/new
  # GET /signups/new.json
  def new
    @event = Event.find(params[:event_id])
    @signup = Signup.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @signup }
    end
  end

  # GET /signups/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @signup = @event.signups.find(params[:id])
  end

  # POST /signups
  # POST /signups.json
  def create
    @event = Event.find(params[:event_id])
    @event.signups.new(params[:signup])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Signup was successfully created.' }
        format.json { render json: @event, status: :created, signup: @signup }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /signups/1
  # PUT /signups/1.json
  def update
    @event = Event.find(params[:event_id])
    @signup = @event.signups.find(params[:id])

    respond_to do |format|
      if @signup.update_attributes(params[:signup])
        format.html { redirect_to @event, notice: 'Signup was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signups/1
  # DELETE /signups/1.json
  def destroy
    @event = Event.find(params[:event_id])
    @signup = @event.signups.find(params[:id])
    @signup.destroy

    respond_to do |format|
      format.html { redirect_to @event }
      format.json { head :ok }
    end
  end

  def unvote
    @signup = Signup.find(params[:id])
    current_user.unvote(@signup)
    redirect_to signup_url(params[:id]), :notice => "Vote has been reset."
  end

  def vote_down
    @signup = Signup.find(params[:id])
    current_user.vote(@signup, :down)
    redirect_to signup_url(params[:id]), :notice => "Vote down is successfully submitted."
  end

  def vote_up
    @signup = Signup.find(params[:id])
    current_user.vote(@signup, :up)
    redirect_to signup_url(params[:id]), :notice => "Vote up is successfully submitted."
  end
  
  def switch_status
    @signup = Signup.find(params[:id])
    if @signup.active?
      @signup.active = false
    else
      @signup.active = true
    end
    @signup.save
    redirect_to signups_url
  end
end
