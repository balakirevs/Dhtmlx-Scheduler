class WorksController < ApplicationController
	before_action :set_work, only: [:show, :edit, :update, :destroy]
  before_action :set_period
  before_action :authenticate_user!

  def index
    @works = period_class.all
    respond_to do |format|      
      format.html
      format.xml  { render :layout => false} 
      format.json 
    end
  end

  def show
  end

  def new
    @work = period_class.new
  end

  def edit
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: "#{period} was successfully created."
    else
      render action: 'new'
    end
  end

  def update
    if @work.update(work_params)
      redirect_to @work, notice: "#{period} was successfully created."
    else
      render action: 'edit'
    end
  end


  def destroy
    @work.destroy
    redirect_to works_url
  end

  private

  def set_period
    @period = period
  end

  def period
    Work.periods.include?(params[:type]) ? params[:type] : "Work"
  end

  def period_class
    period.constantize
  end

  def set_work
    @work = period_class.find(params[:id])
  end

  def work_params
    params.require(period.underscore.to_sym).permit(:id, :label, :period, :user_id)
  end
end
