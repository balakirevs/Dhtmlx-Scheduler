class MembersController < TeamsController
	before_action :authenticate_user!
	
  def index
    @members = current_user.team
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end

  def show
    @members = Team.find(params[:id])
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end
end