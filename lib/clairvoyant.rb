require "clairvoyant/version"

module Clairvoyant
  class Builder
    def initialize(klass_name:, indent_size: 2)
      @klass_name    = klass_name
      @indent_size   = indent_size
      @klass_methods = []
    end

    def indent(times = 1)
      ' ' * (@indent_size * times)
    end

    def klass
      -> method_string {
        "class #{@klass_name}\n" << method_string << "end"
      }
    end

    def inject_method(name)
      @klass_methods << name[1..-1]
    end

    def compose_klass
      klass.call @klass_methods.reduce('') { |method_string, method|
        method_string <<
          "\n" <<
          "#{indent(1)}def #{method}\n" <<
            "#{indent(2)}# Code goes here eventually\n" <<
          "#{indent(1)}end" <<
          "\n\n"
      }
    end

    def save_as(path)
      File.open(path, 'w') { |file| file << compose_klass }
    end
  end


  class << self
    # RSPEC describe parser
    #
    # @param description [String] - What we're describing
    #
    # @return [type] [description]
    def describe(description, &block)
      @builder.inject_method(description) if description[0] == '#'
      block.call rescue nil
    end

    def grok(file_name)
      file  = File.open(file_name, 'r')
      klass = ''

      # Look for the first describe and start there, so we get rid of
      # helpers and includes.
      cleaned_lines = file.drop_while { |line|
        !line.include?('describe')
      }.tap { |lines|
        # Yank constants out of the first line - better suggestions welcome
        begin
          self.class_eval "#{lines[0]}end"
        rescue NameError => e
          klass    = /constant Clairvoyant::(?<klass>.+)$/.match(e.message)[:klass]
          lines[0] = "describe '#{klass}' do"
        end
      }.join("\n")

      @builder = Clairvoyant::Builder.new(klass_name: klass)

      self.class_eval cleaned_lines

      @builder
    end
  end
end
