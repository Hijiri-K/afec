class MessageBroadcastJob < ApplicationJob
  queue_as :default
    def perform(message)
      # Do something later
      # ActionCable.server.broadcast 'room_channel', message: render_message(message)
      group = message.group
       RoomChannel.broadcast_to(group, message: render_message(message), user_id: message.user_id)
    end

    private
      def render_message(message)
        ApplicationController.renderer.render(partial: 'messages/message', locals: {message: message})
      end
end
    # Do something later
