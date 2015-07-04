module Clairvoyant
  # Used to build up Clairvoyant generated classes
  #
  # @author [lemur]
  class Builder
    include Indentable

    attr_accessor :klass_name

    def initialize(klass_name: nil, indent_size: 2)
      @klass_name    = klass_name
      @indent_size   = indent_size
      @klass_methods = []
    end

    # Used to format the klass.
    #
    # @note I don't like the way this is written, clean later
    #
    # @return [Proc]
    def klass
      -> method_string {
        "class #{@klass_name}\n" << method_string.rstrip << "\nend"
      }
    end

    # Adds a method to the builder
    #
    # @param name [String] - Name of the method
    #
    # @return [Array[Clairvoyant::Method]] - Current methods
    def add_method(name)
      @klass_methods << Method.new(name: name[1..-1])
    end

    # Composes a Ruby Class from the builder
    #
    # @return [String] - Saveable and Runnable Ruby Class
    def compose_klass
      klass.call @klass_methods.reduce('') { |method_string, method|
        method_string << "#{method}\n\n"
      }
    end

    # Alias for compose_klass
    #
    # @return [String]
    def to_s
      compose_klass
    end

    # Saves the generated class as a file
    #
    # @param path [String] - Where to save
    #
    # @return [Unit]
    def save_as(path)
      File.open(path, 'w') { |file| file << compose_klass }
    end
  end
end
