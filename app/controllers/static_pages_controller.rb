class StaticPagesController < ApplicationController
	def home
			@ads = Ad.paginate(:page => params[:page], :per_page => 20)
			@ad = current_user.ads.build if user_signed_in?
	end	
	def help
	end
	def about
	end
end
