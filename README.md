# Akane::Notifier

A plugin for [akane](https://github.com/sorah/akane) which allows firing notifications of matched tweets (based on configuration) to several services.
Sucessor of akane-imkayac.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'akane-notifier'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install akane-notifier

## Usage

TODO: Write usage instructions here

``` yaml
# akane.yml
storages:
  #- stdout
  - notifier:
      keywords:
        - mykeyword
      match_ruby:
        - "tweet.user.screen_name == 'xxx' && tweet.text.include?('test')"
      recipients:
        - slack:
            webhook_url: ...
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

