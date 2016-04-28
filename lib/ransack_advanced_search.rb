require 'rails'
require 'ransack'

require 'ransack_advanced_search/engine'
require 'ransack_advanced_search/version'
require 'ransack_advanced_search/helpers/configuration'

module RansackAdvancedSearch
  extend Configuration

  define_setting :enable_saved_searches, false
end
