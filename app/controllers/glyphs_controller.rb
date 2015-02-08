class GlyphsController < ApplicationController
  before_action :logged_in_user
  before_action :correct_user,   only: [:edit, :update, :destroy]

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
    @glyph = Glyph.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, we couldn't find what you're looking for."
    redirect_to(root_url)
  end

  def edit
    @glyph = Glyph.find(params[:id])
  end

  def update
    @glyph = Glyph.find(params[:id])
    if @glyph.update_attributes(glyph_params)
      flash[:success] = "Glyph updated"
      redirect_to @glyph
    else
      render 'edit'
    end
  end

  private

    def glyph_params
      params.require(:glyph).permit(:content, :title, :tagline)
    end

    def correct_user
      @glyph = current_user.glyphs.find_by(id: params[:id])
      redirect_to root_url if @glyph.nil?
    end

end
