class RelationshipsController < ApplicationController
  def create
    followed = User.find(params[:user_id])
    relationship = Relationship.new
    relationship.followed = followed
    relationship.follower = current_user
    relationship.save
    redirect_to request.referer
  end

  def destroy
    followed = User.find(params[:user_id])
    relationship = Relationship.find_by(followed: followed, follower: current_user)
    relationship.destroy
    redirect_to request.referer
  end
end
