class GlyphsController < ApplicationController
  before_action :logged_in_user

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
  end

  def show
    @glyph = Glyph.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:warning] = "Sorry, we couldn't find what you're looking for."
    redirect_to(root_url)
  end

  private

    def glyph_params
      params.require(:glyph).permit(:content, :title, :tagline)
    end

end
