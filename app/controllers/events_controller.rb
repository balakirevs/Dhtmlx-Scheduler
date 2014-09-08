class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    respond_to do |format|
      format.html      
      format.json { render :layout => false}      
    end
  end

  def schedule
    @event = Event.new
    @users = User.all
    @teams = Team.all
    #0@users = @team.users
  end

  def save
    @id = params["id"]
    @tid = @id
    @text = params[:text]    
    @start_date = params[:start_date].to_time().strftime("%Y-%m-%d %H:%i")
    @end_date = params[:end_date].to_time().strftime("%Y-%m-%d %H:%i")
    @user_id = params[:unit_id]
    @mode = params["!nativeeditor_status"]

    if @mode == "inserted"
      @event = Event.new
      @event.text = @text      
      @event.start_date = @start_date
      @event.end_date = @end_date
      @event.user_id = @user_id      
      @event.save!           
      @tid = @event.id
    elsif @mode == "deleted"
      @event = Event.find(@id)
      @event.destroy
    elsif @mode == "updated"
      @event = Event.find(@id)
      @event.text = @text      
      @event.start_date = @start_date
      @event.end_date = @end_date
      @event.user_id = @user_id      
      @event.save!     
    end
    request.format = "xml"
    respond_to do |format|
      format.xml {render :layout => false}
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    flash[:notice] = "The event was successfully added."
    logger.debug "The event was successfully created!"
    
    @event = Event.new(event_params)
    @event.user_id = user_id

    respond_to do |format|
      if @event.save
        format.js
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }  
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:text, :start_date, :end_date)
    end
end
