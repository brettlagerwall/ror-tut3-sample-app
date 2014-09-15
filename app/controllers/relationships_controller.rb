class RelationshipsController < ApplicationController
  before_filter :authenticate
  skip_before_action :verify_authenticity_token

  respond_to :html, :js

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    respond_with @user
  end

  private

    def relationship_params
      params.require(:relationship).permit(:follower_id, :followed_id)
    end
end
