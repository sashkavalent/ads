class StaticPagesController < ApplicationController
	def home
		@ads = Ad.where(:user_id => 1).paginate(:page => params[:page], :per_page => 20)
	end
	def help
	end
	def about
	end
end
