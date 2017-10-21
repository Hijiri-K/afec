class HomeController < ApplicationController
  def top
  end

  def about
  end

  def updates
    @updates = Update.all.order(created_at: :desc)
  end

  def test
  end

  def test2
  end


end
