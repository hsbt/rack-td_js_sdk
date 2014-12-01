# Rack::TdJsSdk

TreasureataのJavaScrip SDKとpageviewタグを自動で挿入します。

## Usage

1. Add `gem 'rack-td_js_sdk'` to Gemfile.
2. Add `config.middleware.use Rack::TdJsSdk, database: "foo", write_key: "..."` to `config/application.rb` if use Rails4.
3. Run `rails s` !!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-td_js_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-td_js_sdk

## Contributing

1. Fork it ( https://github.com/hisaichi5518/rack-td_js_sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
