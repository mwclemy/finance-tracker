class FriendshipsController < ApplicationController
  def create
  end

  def destroy
    friendship = Friendship.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Stopped following"
    redirect_to my_friends_path
  end
end
