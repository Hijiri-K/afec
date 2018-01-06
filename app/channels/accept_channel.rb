class AcceptChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for current_user.id
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def accept(data)
    AcceptBroadcastJob.perform_later data
  end
end
