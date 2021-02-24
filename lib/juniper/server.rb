# typed: strict
# frozen_string_literal: true

require 'rack/builder'

module Juniper
  # Runs a Juniper project's configuration. This acts as essentially Rack middleware.
  class Server
    extend T::Sig

    RackEnv = T.type_alias { T::Hash[String, String] }
    RackTriplet = T.type_alias { [Integer, T::Hash[String, String], T.untyped] }

    # Creates a new Rack application with the router. We mount each application in the configuration and run the whole
    # thing as one app.
    #
    # @param configuration [Juniper::Configuration]
    # @return [Juniper::Configuration]
    sig { params(configuration: Juniper::Configuration).returns(Juniper::Router) }
    def initialize(configuration)
      @builder = T.let(Rack::Builder.new, Rack::Builder)
      @routes = T.let(Juniper::Router.new, Juniper::Router)

      configuration.mounted.each do |application_klass, app|
        routes.mount(application_klass, at: app.path_prefix, host: app.host)
      end

      @app = T.let(builder.run(routes), Juniper::Router)
    end

    # Run a request through the whole server.
    #
    # @param env [RackEnv]
    # @return [RackTriplet]
    sig { params(env: RackEnv).returns(RackTriplet) }
    def call(env)
      app.call(env)
    end

    private

    sig { returns(Rack::Builder) }
    attr_reader :builder

    sig { returns(Juniper::Router) }
    attr_reader :routes

    sig { returns(Juniper::Router) }
    attr_reader :app
  end
end
