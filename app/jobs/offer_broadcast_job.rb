class OfferBroadcastJob < ApplicationJob
  queue_as :default

  def perform(offer)
    OfferChannel.broadcast_to(offer['user_id'], offer: render_offer(offer))
 end

 private
   def render_offer(offer)
     ApplicationController.renderer.render(partial: 'offers/offer', locals: {offer: offer})
   end
    # Do something later
end
