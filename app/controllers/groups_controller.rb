class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    group = Group.new(group_params)
    group.owner_user = current_user
    if group.save
      redirect_to group_path(group)
    else
      @group = group
      render 'users/index'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    unless @group.owner.user_id == current_user.id
      redirect_to group_path(@group)
    end
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render 'users/index'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
