class AssignmentsController < ApplicationController

  def index
    @assignments = params[:q] ? Assignment.search_for(params[:q]) : Assignment.all
  end

  def new
    @assignment = Assignment.new
  end

  def create
    @assignment = Assignment.new(safe_assignment_params)
    if @assignment.save
      redirect_to @assignment
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @assignment.update(safe_assignment_params)
      redirect_to @assignment
    else
      render 'edit'
    end
  end

  def show
  end

  private

  def safe_assignment_params
    params.require(:assignment).permit(:user_id, :story_id, :post)
  end

  def load_assignment
    @assignment = Assignment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash.now[:notice] = "Invalid Assignment ID #{params[:id]}"
    redirect_to root_path
  end



end
