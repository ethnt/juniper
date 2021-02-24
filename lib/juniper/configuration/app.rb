# typed: strict
# frozen_string_literal: true

module Juniper
  class Configuration
    # A configured Juniper app.
    # @private
    class App < SimpleDelegator
      extend T::Sig

      sig { returns(T.nilable(String)) }
      attr_reader :path_prefix

      sig { returns(T.nilable(String)) }
      attr_reader :host

      sig { params(application: T.class_of(Juniper::Application), options: T::Hash[Symbol, String]).returns(self) }
      def initialize(application, options = {})
        super(application)
        @path_prefix = T.let(options[:at], T.nilable(String))
        @host = T.let(options[:host], T.nilable(String))
        self
      end
    end
  end
end
