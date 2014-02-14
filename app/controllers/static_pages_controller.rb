class StaticPagesController < ApplicationController
  def home
    @message = current_user.messages.create if signed_in?
  end
end
