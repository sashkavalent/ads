class AnnouncementsController < ApplicationController
  load_and_authorize_resource

  def destroy
    @announcement.destroy
    redirect_to :back
  end

  def index
    @announcements = Announcement.where(user_id: current_user)
  end

  def clear
    @announcements = Announcement.where(user_id: current_user)
    @announcements.destroy_all
    redirect_to :back
  end
end
