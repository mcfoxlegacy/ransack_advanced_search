class SavedSearch < ActiveRecord::Base
  validates_presence_of :context, :description, :search_params

  serialize :search_params
end
