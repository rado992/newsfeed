class StaticPagesController < ApplicationController
  def home
    if signed_in?
    	@message = current_user.messages.build
    	@feed_items = Message.nin(user_id: current_user.blocked).desc(:created_at).limit(6) #Message.all
    end
  end
end
