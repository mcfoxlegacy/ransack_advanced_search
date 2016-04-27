class CreateRansackAdvancedSearchSavedSearch < ActiveRecord::Migration
  def change
    create_table :saved_searches do |t|
      t.string :context, null: false
      t.string :description, null: false
      t.text :search_params, null: false

      t.timestamps null: false
    end
  end
end
