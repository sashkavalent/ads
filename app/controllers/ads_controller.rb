class AdsController < ApplicationController
	def create
		@ad = current_user.ads.build(params[:ad])
		if @ad.save
			flash[:notice] = "Ad is created"
			redirect_to(:back)
		else
			render root_path
		end
	end
	def destroy
		@ad = Ad.find_by_id(params[:id])
		@ad.destroy
		flash[:notice] = "Ad is deleted"
		redirect_to(:back)
	end
	def index
		@ads = Ad.paginate(:page => params[:page], :per_page => 20)
	end
	def update
		@ad = Ad.find_by_id(params[:id])
		@ad.content = params[:ad][:content]
		@ad.photos_attributes = params[:ad][:photos_attributes]
		@ad.save
		redirect_to profile_path
	end
	def show
		@ad = Ad.find_by_id(params[:id])
	end
	def change_state
		@ad = Ad.find_by_id(params[:id])
		@ad.public_send(params[:state_event])
		@ad.save
		flash[:notice] = "Status of ad was changed"
		redirect_to(:back)
	end
end
