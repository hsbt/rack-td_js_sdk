require 'test/unit'
require 'rack/test'
require 'rack/td_js_sdk'

class Test::Unit::TestCase
  include Rack::Test::Methods
end

class TestApp
  def call(env)
    [
      200,
      { 'Content-Type' => 'text/html' },
      ['<html><head></head><body></body></html>']
    ]
  end
end

class TdJsSdkTest < Test::Unit::TestCase
  def app
    Rack::Builder.new {
      map "/" do
        use ::Rack::TdJsSdk, database: "foo", write_key: "..."
        run TestApp.new
      end
    }.to_app
  end

  def test_include_sdk
    get '/'
    assert last_response.body.include?(%Q!</script>\n</head>!)
  end

  def test_include_database
    get '/'
    assert last_response.body.include?(%Q!database: "foo"!)
  end

  def test_include_write_key
    get '/'
    assert last_response.body.include?(%Q!writeKey: "..."!)
  end
end
