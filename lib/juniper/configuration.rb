# typed: strict
# frozen_string_literal: true

module Juniper
  # The configuration of a Juniper project, consisting of one or more Juniper applications.
  class Configuration
    extend T::Sig

    require_relative 'configuration/app'

    sig { params(blk: T.proc.returns(Juniper::Configuration)).returns(Juniper::Configuration) }
    def initialize(&blk)
      @_configuration = T.let({}, T::Hash[Symbol, T.untyped])
      instance_eval(&blk)
    end

    # Mount an application into this configuration.
    #
    # @param application [Juniper::Application]
    # @param options [Hash]
    # @return [Juniper::Configuration::App]
    sig do
      params(
        application: T.class_of(Juniper::Application),
        options: T::Hash[Symbol, String]
      ).returns(Juniper::Configuration::App)
    end
    def mount(application, options)
      mounted[application] = Configuration::App.new(application, options)
    end

    sig { returns(T::Hash[T.class_of(Juniper::Application), Juniper::Configuration::App]) }
    def mounted
      @_configuration.fetch(:mounted, {})
    end
  end
end
