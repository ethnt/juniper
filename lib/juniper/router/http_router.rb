# typed: strict
# frozen_string_literal: true

require 'http_router'

module Juniper
  class Router
    class HttpRouter < ::HttpRouter
      # Mount a Rack app.
      def mount(app, options)
        add("#{ options.fetch(:at) }*", host: options[:host]).to(
          @resolver.resolve(to: app)
        )
      end
    end
  end
end
