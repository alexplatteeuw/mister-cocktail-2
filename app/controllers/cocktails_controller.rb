class CocktailsController < ApplicationController

  before_action :find_cocktail, only: [:show, :destroy, :edit, :update]

  def index
    @cocktails = Cocktail.all.includes(photo_attachment: :blob).sort_by(&:name)
  end

  def new
    @cocktail = Cocktail.new
  end

  def show
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    @cocktail.update(cocktail_params)
  end

  def destroy
    @cocktail.destroy
  end

  private

  def cocktail_params
    params.require(:cocktail).permit(:name, :photo)
  end

  def find_cocktail
    @cocktail = Cocktail.find(params[:id])
  end
end
