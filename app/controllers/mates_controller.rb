class MatesController < TeamsController
	before_action :authenticate_user!
	
  def index
    @mates = current_user.team
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end

  def show
    @mate = Team.find(params[:id])
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end
end