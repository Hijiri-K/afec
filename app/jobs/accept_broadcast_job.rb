class AcceptBroadcastJob < ApplicationJob
  queue_as :default

  def perform(accept)
    AcceptChannel.broadcast_to(accept['id'], accept: render_accept(accept))
    ActionCable.server.broadcast 'delete_channel', id: accept['id'], userId: accept['user_id']
    post1 = Post.find_by(user_id: accept['id'])
    post2 = Post.find_by(user_id: accept['user_id'])
    post1.destroy
    post2.destroy
    # TODO：broadcastする対象をmessageのnarita1JPYUSDとNatira1USDJPYだけにするなどして対象を絞る必要あり
 end

 private
   def render_accept(accept)
     ApplicationController.renderer.render(partial: 'accepts/accept', locals: {accept: accept})
   end
    # Do something later
end
