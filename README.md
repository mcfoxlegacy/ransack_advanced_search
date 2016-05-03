[![Gem Version](https://badge.fury.io/rb/ransack_advanced_search.svg)](https://badge.fury.io/rb/ransack_advanced_search)

# Ransack Advanced Search

[ransack](https://github.com/activerecord-hackery/ransack) is a Object-based searching for Rails.

The `ransack_advanced_search` gem provides Bootstrap based templates for the [ransack](https://github.com/activerecord-hackery/ransack) Advanced query mode. This gem also provides some additional features to make search experience better and easy to use.

## Features
* Full [ransack](https://github.com/activerecord-hackery/ransack) compatibility (you can still use the default [ransack](https://github.com/activerecord-hackery/ransack) features);
* Ransack integrated Advanced Search mode with helpers and views - extracted from [ransack-demo](https://github.com/activerecord-hackery/ransack_demo) project;
* Saved Searches, scoped by contexts, to persist search params and use it in the future;
* Custom search value inputs based on data type;
* TODO: scope by current user or current account (abstract scope).

## Installation

Remove any entry of `ransack` gem from your application's Gemfile. The `ransack_advanced_search` gem will include the `ransack` gem as a dependency.

Add this line to your application's Gemfile:

```ruby
gem 'ransack_advanced_search'
```

Execute:

    $ bundle

Or install it yourself as:

    $ gem install ransack_advanced_search

Run the generator to install the gem initializer, this will create the file `config/initializers/ransack_advanced_search.rb`:

    $ rails generate ransack_advanced_search:install

For while we don't need to change this file.

## Usage

First, in your controller action that you will use for search, include the following:

```ruby
# GET /your_models
# GET /your_models.json
# POST /your_models/advanced_search
def index
  # The ransack search must be in the @search instance variable, because the advanced search will use it to build the search form. You must provide associations you will use in the includes method.
  @search = YourModel.search(params[:q])
  @results = @search.result().includes(:association1, :association2)
  # or, if the above doesn't work
  @search = YourModel.ransack(params[:q])
  @results = @search.result(:association1, :association2)
end
```

To use the Advanced Search with associtions you must provide a method in your model to tell what are the associations for that model
```ruby
  class YourModel < ActiveRecord::Base
    # Associations to be included in the search attributes
    def self.ransackable_associations(*)
      %w( association1 association2 )
    end
  end
```

By default ransack will provide all your model fields to the avaliable field to search. You can restrict what fields will be included in the Advanced Search by defining it in your model, like this:
```ruby
  class YourModel < ActiveRecord::Base
    # Fields that will be included in ransack advanced search
    def self.ransackable_attributes(*)
      %w( name description other_fields_names ) + _ransackers.keys
    end
  end
```

This rule applies to each model included in the search, even in the associations you can restrict fields to search.


Now, we have to create a POST route to this action, in your `config/routes.rb` provide a POST route to this controller/action:

```ruby
# For example
resources :your_models do
  collection do
    match :advanced_search, to: 'your_models#index', via: :post
  end
end
```

We have a ransack search well configured, from this step we will include the Advanced Search query mode in our views.

In your application layout `app/views/layouts/application.erb`, include a yield in the head section to load ransack advanced search dependencies:
```html
<html>
  <head>
    <!-- Your app resources -->
    <%= yield(:ransack_advanced_search_setup) %>
  </head>
  <body>
  </body>
</html>
```
In the view that you want the advanced search views you can choose betwenn quick_search and advanced_search views, so insert the following for advanced_search:

```ruby
  <%= render partial: 'ransack_advanced_search/advanced_search',
    locals: {
       search_url: advanced_search_your_models_path, # POST route we created above
       redirect_path: your_models_path # GET redirect path, to return after some actions
    }
  %>
```

Or, the following for quick_search:

```ruby
  <%= render partial: 'ransack_advanced_search/quick_search',
    locals: {
       search_url: advanced_search_your_models_path, # POST route we created above
       redirect_path: your_models_path # GET redirect path, to return after some actions
    }
  %>
```
IMPORTANT: If you are using saved searches and you want to change from quick search to advanced search views or vice versa, you must provide a new context for this saved searches or delete all saved search for that context before changing the view.

All done! Enjoy the search!

## Saving Searches

If you want to provide the feature to Save ransack searches, follow these steps.

Enable Saved Searches configuration in `config/initializers/ransack_advanced_search.rb`:

```ruby
config.enable_saved_searches = true
```

Run this command to generate the Saved Search Migration:

    $ rails generate ransack_advanced_search:saved_search

Execute:

    $ rake db:migrate

In each controller action with the Advanced Search:

* Include the Saved Search Utils methods:
```ruby
include RansackAdvancedSearch::SavedSearchUtils
```

* Insert this line before creating the search:
```ruby
# GET /your_models
# GET /your_models.json
# POST /your_models/advanced_search
def index
  # Call this methods passing a context(to scope the saved searches, can be any symbol) and the params variable
  params[:q] = perform_saved_searches_actions(:your_models_index, params)
  @search = YourModel.search(params[:q])
  @results = @search.result()
end
```
IMPORTANT: if you use custom inflections settings, you can receive this error:
```
Table 'calendario_development.saved_searchs' doesn't exist
```
To avoid this you will have to include an irregular inflection:
```ruby
inflect.irregular 'saved_search', 'saved_searches'
```

## i18n Support

This gem was built using i18n translation supports, and has bult-in support for English (en) and Brazilian Portuguese (pt-BR). If you want to translate to your specific language, add a new locale file in your `config/locales` and translate the values to your language. You can get one of the locales of this project to make it easier to translate to your language.


## Contributing

1. Fork it ( https://github.com/davidbrusius/ransack_advanced_search/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

This project uses MIT-LICENSE.
