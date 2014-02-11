# ---------------------------------------------------------------------------
# Various printers and logging
# ---------------------------------------------------------------------------
require 'awesome_print'
require 'pp'
require 'logger'
require 'rspec'

# ---------------------------------------------------------------------------
# Ensure LOAD_PATH is set for correct execution
# ---------------------------------------------------------------------------
$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(Dir.pwd, 'lib'))

require 'bundler/setup'

# ---------------------------------------------------------------------------
# Require everything in spec/support
# ---------------------------------------------------------------------------
Dir[File.expand_path('./spec/support/**/*.rb')].map(&method(:require))

# ---------------------------------------------------------------------------
# Configure rspec
# ---------------------------------------------------------------------------
RSpec.configure do |config|

  config.order         = 'random'
  config.failure_color = :magenta # Mmmmm. Colors...
  config.tty           = true
  config.color         = true
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect] # default, enables both `should` and `expect`
  end

end

