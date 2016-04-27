[![Gem Version](https://badge.fury.io/rb/ransack_advanced_search.svg)](https://badge.fury.io/rb/ransack_advanced_search)

# Ransack Advanced Search

[ransack](https://github.com/activerecord-hackery/ransack) is a Object-based searching for Rails.

The `ransack_advanced_search` gem provides Bootstrap based templates for the [ransack](https://github.com/activerecord-hackery/ransack) Advanced query mode. This gem also provides some additional features to make search experience better and easy to use.

## Features
* Full [ransack](https://github.com/activerecord-hackery/ransack) compatibility (you can still use the default [ransack](https://github.com/activerecord-hackery/ransack) features);
* Ransack integrated Advanced Search mode with helpers and views - extracted from [ransack-demo](https://github.com/activerecord-hackery/ransack_demo) project;
* Saved Searches, scoped by contexts, to persist search params and use it in the future;
* TODO: custom search value inputs based on data type.

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

## Usage

## Contributing

1. Fork it ( https://github.com/davidbrusius/ransack_advanced_search/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

This project uses MIT-LICENSE.
