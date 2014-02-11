module Ruby
  module Class
    module Unloading
      # -----------------------------------------------------------------------
      # Just a bunch of exceptions for demonstration purposes
      # -----------------------------------------------------------------------
      class ClassNotInitializedError < StandardError
        def to_s
          'You really need to make sure the singleton is completely initialized before calling any method.'
        end
      end

      class SingletonInstantiationError < StandardError
        def to_s
          'This class is a singleton. You cannot instantiate it.'
        end
      end

      class InvalidEnvironmentError < StandardError
        def initialize(environment)
          @environment = environment
        end

        def to_s
          "You need to set the environment to one of test, development, stage or production! [#{@environment}] is not one of those"
        end
      end

      class PathNotFoundError < StandardError
        def initialize(path)
          @path = path
        end

        def to_s
          "The path supplied [#{@path}] could not be found!"
        end
      end

      class FileNotReadableError < StandardError
        def initialize(path)
          @path = path
        end

        def to_s
          "The file supplied [#{@path}] is not readable!"
        end
      end

      class FileNotWritableError < StandardError
        def initialize(path)
          @path = path
        end

        def to_s
          "The file supplied [#{@path}] is not writable!"
        end
      end

      class NotValidJsonError < StandardError
        def initialize(path, e)
          @path      = path
          @exception = e
        end

        def to_s
          "The file supplied [#{@path}] does not contain valid JSON!\n#{@exception}\nBacktrace:\n#{@exception.backtrace.join("\n")}"
        end
      end

      class NotValidYamlError < StandardError
        def initialize(path)
          @path = path
        end

        def to_s
          "The file supplied [#{@path}] does not contain valid YAML!"
        end
      end

    end
  end
end
