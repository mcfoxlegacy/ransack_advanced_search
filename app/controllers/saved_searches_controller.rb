class SavedSearchesController < ApplicationController
  before_action :set_saved_search, only: [:destroy]

  # DELETE /saved_search/1
  # DELETE /saved_search/1.json
  def destroy
    @saved_search.destroy
    respond_to do |format|
      redirect_path = params[:redirect_to] || root_path
      format.html { redirect_to redirect_path, notice: t('ransack.saved_search.delete.success') }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_search
      @saved_search = SavedSearch.find(params[:id])
    end
end
