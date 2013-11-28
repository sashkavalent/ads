class CommentsController < ApplicationController
  load_and_authorize_resource

  def create

    comment = current_user.comments.build(params[:comment])
    comment.ad_id = params[:ad_id]

    ad = Ad.find_by_id(params[:ad_id])
    ann = ad.user.announcements.build(ad_id: params[:ad_id],
      content: t(:ad_was, scope: [:ads]) +
      t(:commented, scope: [:comments]))

    if comment.save && ann.save
      flash[:notice] = t(:added, scope: [:comments])
      params[:comment] = nil
    else
      flash[:error] = @comment.errors.full_messages.join('. ')
    end
    redirect_to :back

  end

  def destroy

    @comment.destroy
    flash[:notice] = t(:deleted, scope: [:ads])
    redirect_to(:back)

  end

end
