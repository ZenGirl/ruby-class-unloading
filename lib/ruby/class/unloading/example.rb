require 'yaml'

module Ruby
  module Class
    module Unloading

      class Example

        # -------------------------------------------------------------------
        # Note: We do not use this construct:
        # @@instance = MySingleton.new
        # As it will cause eager loading
        # We use this instead:
        # -------------------------------------------------------------------
        def self.instance
          #noinspection RubyClassVariableUsageInspection
          @@instance ||= new
        end

        # -------------------------------------------------------------------
        # We could use
        # private_class_method :new
        # But a MySingleton.new will raise NoMethodError instead of our custom one
        # -------------------------------------------------------------------

        # -------------------------------------------------------------------
        # Blow up if the call +#new+
        # -------------------------------------------------------------------
        def initialize
          raise SingletonInstantiationError
        end

        class << self

          # -------------------------------------------------------------------
          # I'm deliberately using class instance variables here!
          # Just for demonstration...
          # -------------------------------------------------------------------

          # -------------------------------------------------------------------
          # Logger - for the hell of it.
          # -------------------------------------------------------------------
          def logger
            @logger || ::Logger.new(STDOUT)
          end

          def logger=(logger)
            @logger = logger
          end

          # -------------------------------------------------------------------
          # Initialized flag
          # -------------------------------------------------------------------
          def initialized
            @initialized
          end

          def initialized=(value)
            @initialized = value
          end

          # -------------------------------------------------------------------
          # Environment
          # -------------------------------------------------------------------
          def environment
            @environment
          end

          def environment=(value)
            @environment = value
          end

          # -------------------------------------------------------------------
          # Configure is where it happens!
          # -------------------------------------------------------------------
          def configure(environment, database_yml)

            logger.info "Ruby::Class::Unloading::Example Starting with environment => [#{environment}] and database_yml => [#{database_yml}]"

            # We start uninitialized
            @initialized = false

            # Blow up if they didn't pass a valid environment
            raise InvalidEnvironmentError.new(environment) unless %w(test development stage production).include? environment.to_s

            # Blow up if the file is not readable
            raise FileNotReadableError.new(database_yml) unless File.exist?(database_yml) and File.readable?(database_yml)

            # Read it
            config = YAML.load_file(database_yml)

            # Blow up if it is not valid
            raise NotValidYamlError.new(database_yml) unless config.is_a? Hash

            # Phew. We can conclude configuration
            @environment       = environment
            @initialized       = true
            logger.info "Ruby::Class::Unloading::Example Started with environment => [#{environment}] and database_yml => [#{database_yml}]"

            # Done!
          end

        end

      end

    end
  end
end
