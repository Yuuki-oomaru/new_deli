class ChatsController < ApplicationController
  def show
  	@user = User.find(params[:id])
  	rooms = current_user.user_rooms.pluck(:room_id)
  	user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

	  	unless user_rooms.nil?
	  		@room = user_rooms.room
	  	else
	  		@room = Room.new
	  		@room.save
	  		UserRoom.create(user_id:current_user.id, room_id: @room.id)
	  		UserRoom.create(user_id:@user.id, room_id: @room.id)
	  	end
	  	@chat = Chat.new(room_id: @room.id)
	  	@chats = @room.chats
  end

  def create
  	@chat = current_user.chats.new(chat_params)
    @user_rooms = UserRoom.find_by(room_id: @chat.room_id, user_id:current_user.id)
    @room = @user_rooms.room
    @chats = @room.chats

    @chat.save
  end

  private
  def chat_params
  	params.require(:chat).permit(:message, :room_id)
  end
end
