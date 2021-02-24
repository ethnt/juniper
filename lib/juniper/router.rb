# typed: strict
# frozen_string_literal: true

require 'rack/builder'

module Juniper
  # A Juniper router.
  class Router
    extend T::Sig

    require_relative 'router/http_router'

    sig { returns(T.untyped) }
    def initialize
      @router = T.let(HttpRouter.new, HttpRouter)
    end

    sig { params(env: Server::RackEnv).returns(Server::RackTriplet) }
    def call(env)
      @router.call(env)
    end

    sig { params(app: T.class_of(Juniper::Application), options: T::Hash[Symbol, String]).returns(T.untyped) }
    def mount(app, options)
      @router.mount(app, options)
    end
  end
end
