class CommentsController < ApplicationController
  load_and_authorize_resource

  def create

    comment = current_user.comments.build(params[:comment])
    comment.ad_id = params[:ad_id]

    ann = current_user.announcements.build(ad_id: params[:ad_id],
      content: t(:ad_was, scope: [:ads]) + t(:commented, scope: [:comments]))
    ann.save
    ad = Ad.find(params[:ad_id])

    comment.save

    respond_with(comment,
      :location => ad_path(ad)) do |format|

      if !comment.save
        format.html { redirect_to ad }
      end

  end

  end

  def destroy
    @comment.destroy
    respond_with(@comment, :location => ad_path(@comment.ad))
  end

end
