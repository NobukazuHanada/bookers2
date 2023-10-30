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
      redirect_to group_path(@group.id)
    end
    if @group.update(group_params)
      redirect_to group_path(@group.id)
    else
      render 'users/index'
    end
  end

  def join
    @group = Group.find(params[:id])
    if @group.owner.user_id != current_user.id && !@group.users.exists?(id: current_user.id)
      @group.users.push(current_user)
    end
    redirect_to request.referer
  end

  def leave
    @group = Group.find(params[:id])
    if @group.owner.user_id != current_user.id && @group.users.exists?(id: current_user.id)
      @group.users.destroy(current_user)
    end
    redirect_to request.referer
  end

  def event_create
    @group = Group.find(params[:id])
  end

  def event_notice
    @group = Group.find(params[:id])
    @title = params[:title]
    @body = params[:body]
    unless @group.owner.user_id == current_user.id
      redirect_to group_path(@group.id)
    end
    @group.users.each do |user|
      UserMailer.with(user: user, title: @title, body: @body).event_email.deliver_later
      
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
