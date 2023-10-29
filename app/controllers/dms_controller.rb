class DmsController < ApplicationController
  def index
    @other_user = get_other_user
    send_messages = current_user.dm_sends.where("to_id = ?", @other_user.id)
    receive_message = current_user.dm_receive.where("from_id = ?", @other_user.id)
    @messages = send_messages.or(receive_message).order("created_at")
    @dm = Dm.new
  end

  def create
    other_user = get_other_user
    dm = Dm.new(dm_params)
    dm.from_id = current_user.id
    dm.to_id = other_user.id
    dm.save
    redirect_to request.referer
  end

  private

  def get_other_user
    other_user = User.find(params[:user_id])
    unless other_user.is_mutual_follow(current_user)
      redirect_to users_path
    end
    other_user
  end

  def dm_params
    params.require(:dm).permit(:body)
  end

end
