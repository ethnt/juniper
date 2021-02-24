# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative 'juniper/version'

require_relative 'juniper/configuration'
require_relative 'juniper/router'
require_relative 'juniper/server'

# A web framework for Ruby.
module Juniper
  extend T::Sig

  sig do
    params(
      blk: T.proc.returns(Juniper::Configuration)
    ).returns(T.nilable(Juniper::Configuration))
  end
  def self.configure(&blk)
    @configuration = T.let(Juniper::Configuration.new(&blk), T.nilable(Juniper::Configuration))
  end

  sig { returns(Juniper::Configuration) }
  def self.configuration
    raise 'Juniper not configured' unless defined?(@configuration)

    T.must(@configuration)
  end

  sig { returns(Juniper::Server) }
  def self.server
    Juniper::Server.new(configuration)
  end
end
