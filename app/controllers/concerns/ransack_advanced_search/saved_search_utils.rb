module RansackAdvancedSearch
  module SavedSearchUtils
    extend ActiveSupport::Concern

    # Perform saved searches actions to provide full functionality with one method
    def perform_saved_searches_actions(context, params={})
      get_saved_searches(context)
      save_or_update_saved_search(params.merge(context: context))
      get_params_to_search(context)
    end

    # Get list of Saved Search by context
    def get_saved_searches(context)
      @saved_searches = SavedSearch.where(context: context)
    end

    # Return params of Saved Search or search form params
    def get_params_to_search(context)
      if params[:saved_search].present?
        @saved_search = SavedSearch.find_by(id: params[:saved_search], context: context)
      end
      return params[:q] if params[:use_search_params].present?
      params[:q] = @saved_search.try(:search_params) || params[:q]
    end

    # Save or update Saved Search
    def save_or_update_saved_search(params)
      if params[:save_new_search].present? || params[:save_search].present?
        if params[:save_new_search].present?
          @saved_search = new_saved_search(params)
        elsif params[:save_search].present? && params[:saved_search].present?
          @saved_search = update_saved_search(params)
        elsif params[:save_search].present?
          @saved_search = new_saved_search(params)
        end

        if @saved_search.save
          flash[:notice] = t('ransack.saved_search.save.success')
        else
          flash[:error] = t('ransack.saved_search.save.error')
        end
      end
    end

    def new_saved_search(params)
      SavedSearch.new(
       context: params[:context], description: params[:description],
       search_params: params[:q]
      )
    end

    def update_saved_search(params)
      saved_search = SavedSearch.find_by(id: params[:saved_search], context: params[:context])
      saved_search.description = params[:description]
      saved_search.search_params = params[:q]
      saved_search
    end
  end
end
