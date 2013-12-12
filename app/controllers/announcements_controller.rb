class AnnouncementsController < ApplicationController
  load_and_authorize_resource

  def destroy
    @announcement.destroy
    respond_with(@announcement,
      :location => user_announcements_path(current_user))
  end

  def index
    @announcements = current_user.announcements
  end

  def clear
    current_user.announcements.destroy_all
    redirect_to :back
  end
end
