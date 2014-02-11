require 'spec_helper'

require 'ruby/class/unloading'

describe Ruby::Class::Unloading::Example do

  # -------------------------------------------------------------------------
  # It's a singleton, so we MUST unload and reload the code before each test
  # NOTE!
  # We MUST NOT use described_class as rspec caches the class.
  # We MUST use Ruby::Class::Unloading::Example instead to make rspec behave
  # -------------------------------------------------------------------------
  before(:each) do
    # -----------------------------------------------------------------------
    # First we try to unload the class
    # -----------------------------------------------------------------------
    if defined?(Ruby::Class::Unloading)
      # ---------------------------------------------------------------------
      # You'll see this on each test when you run bundle exec rake spec
      # ---------------------------------------------------------------------
      puts '    Guess what. We\'re unloading the class!'
      Ruby::Class::Unloading.send(:remove_const, :Example)
    end

    # -----------------------------------------------------------------------
    # And now load it
    # Notice the use of +#load+ instead of +#require+
    # -----------------------------------------------------------------------
    load 'ruby/class/unloading/example.rb'

    # -----------------------------------------------------------------------
    # Just configure a logger for the sake of it
    # -----------------------------------------------------------------------
    Ruby::Class::Unloading::Example.logger       = ::Logger.new(STDERR)
    Ruby::Class::Unloading::Example.logger.level = ::Logger::UNKNOWN
  end

  # -------------------------------------------------------------------------
  # Test that the class cannot be instantiated
  # -------------------------------------------------------------------------
  context 'singleton' do

    it 'does not allow instantiation' do
      expect {
        Ruby::Class::Unloading::Example.new
      }.to raise_error(Ruby::Class::Unloading::SingletonInstantiationError)
    end

  end

  # -------------------------------------------------------------------------
  # Test that it can be configured and raises errors if anything is wrong
  # -------------------------------------------------------------------------
  context '#configure' do

    it 'raises an error if supplied database.yml is not readable' do
      # Yeah, yeah. A bad path:
      database_yml = '/a/path/to/a/non/existent/file'

      expect {
        Ruby::Class::Unloading::Example.configure(:test, database_yml)
      }.to raise_error(Ruby::Class::Unloading::FileNotReadableError)
    end

    it 'raises an error if supplied database.yml does not valid yaml' do
      # Oh lord, a good one!
      database_yml = File.join(File.dirname(__FILE__), '../../../support/database_invalid_yaml.yml')

      expect {
        Ruby::Class::Unloading::Example.configure(:test, database_yml)
      }.to raise_error(Ruby::Class::Unloading::NotValidYamlError)
    end

  end

end
