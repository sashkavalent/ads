class AdsController < ApplicationController
	def create
		@ad = current_user.ads.build(params[:ad])
		if @ad.save 
			flash[:notice] = "Ad is created"
			redirect_to root_path
		else
			render root_path
		end	
	end
	def destroy
		@ad = Ad.find_by_id(params[:id])
		@ad.destroy
		flash[:notice] = "Ad is deleted"
		redirect_to root_path
	end
end
