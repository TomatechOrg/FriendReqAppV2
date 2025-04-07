class FriendshipsController < ApplicationController
  before_action :set_friendship, only: %i[ destroy ]
  before_action :authenticate_user!

  # GET /friendships or /friendships.json
  def index
    @friendships = current_user.friendships
  end

  # DELETE /friendships/1 or /friendships/1.json
  def destroy
    if !@friendship.nil? && (@friendship.primary_friend == current_user or @friendship.secondary_friend == current_user)
      @friendship.destroy!
    
      respond_to do |format|
        format.html { redirect_to friendships_path, status: :see_other, notice: "Friendship was successfully destroyed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friendship_params
      params.require(:friendship).permit(:primary_friend_id, :secondary_friend_id)
    end
end
