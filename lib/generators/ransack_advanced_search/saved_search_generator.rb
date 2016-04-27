require 'rails/generators/base'
require 'rails/generators/migration'

module RansackAdvancedSearch
  module Generators
    class SavedSearchGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)
      include Rails::Generators::Migration
      desc "Creates a Saved Search model and migrations to save advanced searches made with Ransack."
      class_option :orm

      desc 'add the migrations'
      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_ransack_advanced_search_saved_search.rb", "db/migrate/create_ransack_advanced_search_saved_search.rb"
      end

    end

  end
end
