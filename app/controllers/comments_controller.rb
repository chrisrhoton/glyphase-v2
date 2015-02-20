class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:destroy]

  def create
    @glyph   = Glyph.find(params[:glyph_id])
    @comment = @glyph.comments.create(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @glyph
    else
      flash[:warning] = "Whoops!  Something went wrong when we tried to create your comment."
    end
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, we couldn't find what you're looking for."
    redirect_to(root_url)
  end

  def destroy
    glyph = @comment.glyph
    @comment.destroy
    redirect_to glyph
  end

  private

    def comment_params
      params.require(:comment).permit(:text, :image_attachment, :panda_video_id)
    end

    # Confirms the correct user.
    def correct_user
      @comment = Comment.find(params[:id])
      redirect_to(root_url) unless current_user?(@comment.user)
    end
end
