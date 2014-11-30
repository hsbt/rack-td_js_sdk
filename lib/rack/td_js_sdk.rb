require 'active_support/core_ext'
require 'erb'

module Rack
  class TdJsSdk
    cattr_accessor :database, :write_key

    def initialize(app, options = {})
      @@database  ||= options[:database]
      @@write_key ||= options[:write_key]

      raise ArgumentError, "`database` must be set!"  if database.blank?
      raise ArgumentError, "`write_key` must be set!" if write_key.blank?
      @app, @options = app, options
    end

    def call(env)
      @status, @headers, @body = @app.call(env)
      if !html?
        return [@status, @headers, @body]
      end
      response = Rack::Response.new([], @status, @headers)
      @body.each { |fragment| response.write inject(fragment) }
      @body.close if @body.respond_to?(:close)

      response.finish
    end

    private
    def html?; @headers['Content-Type'] =~ /html/; end

    def inject(fragment)
      @sdk_template ||= ::ERB.new ::File.read ::File.expand_path("../templates/sdk.erb", __FILE__)
      fragment.gsub!(%r{</head>}, @sdk_template.result(binding) + "</head>")

      @pageview_template ||= ::ERB.new ::File.read ::File.expand_path("../templates/pageview.erb", __FILE__)
      fragment.gsub!(%r{</body>}, @pageview_template.result(binding) + "</body>")
    end
  end
end
