class GroupsController < TeamsController
	before_action :authenticate_user!
	
  def index
    @groups = Team.all
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end
end