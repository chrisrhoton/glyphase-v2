class GlyphsController < ApplicationController
  before_action :logged_in_user, except: [:nearby]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  NOT_VIEWABLE_MESSAGE = "You're not close enough or don't have the permissions necessary to view this glyph."

  def new
    @glyph = Glyph.new
  end

  def create
    @glyph = current_user.glyphs.build(glyph_params)
    if @glyph.save
      flash[:success] = "Glyph created!"
      redirect_to(@glyph)
    else
      render 'new'
    end
  end

  def destroy
    @glyph.destroy
    flash[:success] = "Glyph deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @glyph   = Glyph.find(params[:id])
    @comment = Comment.new
    viewable = viewable?(@glyph)
    if close_enough?(@glyph) && !current_user?(@glyph.user) && !viewed_before?(@glyph)
      @glyph.add_viewer!(current_user)
    end

    if viewable && !@glyph.panda_video_id.empty?
      @original_video = @glyph.panda_video
      @h264_encoding = @original_video.encodings["h264"]
    end

    if !viewable
      @glyph.image_attachment = nil
      @glyph.content = NOT_VIEWABLE_MESSAGE
    end
    
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, we couldn't find what you're looking for."
    redirect_to(root_url)
  end

  def edit
    @glyph = Glyph.find(params[:id])
  end

  def update
    @glyph = Glyph.find(params[:id])
    puts params[:glyph][:latitude]
    puts params[:glyph][:longitude]
    if @glyph.update_attributes(glyph_params)
      flash[:success] = "Glyph updated"
      redirect_to @glyph
    else
      render 'edit'
    end
  end

  def nearby
    latitude = params[:lat]
    longitude = params[:lng]
    if(latitude.nil? || longitude.nil?)
      redirect_to root_url 
    else
      @glyphs = Glyph.close_to(latitude, longitude)
      render json: @glyphs
    end
  end

  private

    def glyph_params
      params.require(:glyph)
            .permit(:content, :title, :tagline, 
                    :image_attachment, :header_image,
                    :latitude, :longitude, :panda_video_id);
    end

    def correct_user
      @glyph = current_user.glyphs.find_by(id: params[:id])
      redirect_to root_url if @glyph.nil?
    end

end
