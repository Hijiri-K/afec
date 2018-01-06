class AcceptBroadcastJob < ApplicationJob
  queue_as :default

  def perform(accept)
    AcceptChannel.broadcast_to(accept['id'], accept: render_accept(accept))
 end

 private
   def render_accept(accept)
     ApplicationController.renderer.render(partial: 'accepts/accept', locals: {accept: accept})
   end
    # Do something later
end
