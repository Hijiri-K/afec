class OfferChannel < ApplicationCable::Channel
  def subscribed
      stream_for current_user.id
    end

    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

    def offer(data)
       OfferBroadcastJob.perform_later data
    end
  end
