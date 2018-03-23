class PostsController < ApplicationController
  # before_action :authenticate_user
  before_action :set_mypost

  def index
    if Post.find_by(user_id: current_user.id)
        @mypost = Post.find_by(user_id: current_user.id)
        # @posts = Post.where(currency_have: @mypost.currency_want, currency_want: @mypost.currency_have)
        @posts = Post.where(currency_have: @mypost.currency_want, currency_want: @mypost.currency_have, location: @mypost.location, terminal: @mypost.terminal, security_area: @mypost.security_area).order(created_at: :desc)
        # @posts = Post.where(group: @mypost.stream)
    else
      @posts = Post.all.order(created_at: :desc)
    end
  end

  def create_transaction
    currency = "#{params[:give_currency]}USD"
    p currency
    exchange = Exchange.find_by(currency: currency)
    rate = exchange.rate
    p rate
    p params[:give_currency_amount]
    Transaction.create!(
      user_id:params[:user_id],
      trade_with_id:params[:trade_with],
      give_currency:params[:give_currency],
      receive_currency:params[:receive_currency],
      # give_currency_amount:params[:give_currency_amount],
      # receive_currency_amount:params[:receive_currency_amount]
      usd_amount:params[:give_currency_amount].to_f*rate
    )
  end

  def successed_transaction
    transaction = Transaction.where(user_id:current_user.id).last
    transaction.update(
      status:"successed"
    )
  end

  def failed_transaction
    transaction = Transaction.where(user_id:current_user.id).last
    transaction.update(
      status:"failed"
    )
  end
end
