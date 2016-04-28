require 'rails/generators/base'

module RansackAdvancedSearch
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      include Rails::Generators::Migration
      desc "Install Ransack Advanced Search"
      class_option :orm

      def copy_initializer
        template "ransack_advanced_search.rb", "config/initializers/ransack_advanced_search.rb"
      end
    end
  end
end
