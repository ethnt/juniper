require_relative '../lib/juniper'

run Juniper::Router.new do
  get '/', to: ->(env) { [200, {}, 'hey'] }
end
