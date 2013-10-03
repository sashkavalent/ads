class AdsController < ApplicationController
	def create
		@ad = current_user.ads.build(params[:ad])
		if @ad.save 
			flash[:success] = "Ad is created"
			redirect_to root_path
		else
			render root_path
		end	
	end
	def destroy
	end
end
