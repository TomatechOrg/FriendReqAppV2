class FriendRequestsController < ApplicationController
  before_action :set_friend_request, only: %i[ accept destroy ]
  before_action :authenticate_user!

  # GET /friend_requests or /friend_requests.json
  def index
    @incoming_requests = current_user.incoming_requests
    @outgoing_requests = current_user.outgoing_requests
  end

  # GET /friend_requests/new
  def new
    @friend_request = FriendRequest.new
  end

  # POST /friend_requests or /friend_requests.json
  def create
    @friend_request = FriendRequest.new(friend_request_params.merge(sender_id: current_user.id))

    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to friend_requests_path, notice: "Friend request was successfully created." }
        format.json { render :show, status: :created, location: @friend_request }
      else
        p @friend_request.errors
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @friend_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /friend_requests/1 or /friend_requests/1.json
  def accept
    if !@friend_request.nil? && @friend_request.receiver == current_user
      # create a friendship based on the friend request
      @friend_request.destroy!
      respond_to do |format|
        format.html { redirect_to friend_requests_path, status: :see_other, notice: "Friend request accepted." }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /friend_requests/1 or /friend_requests/1.json
  def destroy
    if !@friend_request.nil?

      if @friend_request.sender == current_user
        @friend_request.destroy!
        respond_to do |format|
          format.html { redirect_to friend_requests_path, status: :see_other, notice: "Friend request cancelled." }
          format.json { head :no_content }
        end
      elsif @friend_request.receiver == current_user
        @friend_request.destroy!
        respond_to do |format|
          format.html { redirect_to friend_requests_path, status: :see_other, notice: "Friend request rejected." }
          format.json { head :no_content }
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_request
      @friend_request = FriendRequest.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def friend_request_params
      params.require(:friend_request).permit(:receiver_id)
    end
end
