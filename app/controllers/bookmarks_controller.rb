class BookmarksController < ApplicationController
  before_action :set_list, only: [:new]
  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @list = List.find(params[:list_id])
    @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to @bookmark.list, notice: "Bookmark was successfully deleted."
  end

  # def destroy
  #   @bookmark = Bookmark.find(params[:id])
  #   @bookmark.destroy
  #   @list = List.find(params[:list_id])
  #   @bookmark.list = @list
  #   redirect_to list_path(@list), status: :see_other
  # end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
