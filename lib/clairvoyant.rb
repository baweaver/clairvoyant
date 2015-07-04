require "clairvoyant/version"

require 'clairvoyant/indentable'

require 'clairvoyant/builder'
require 'clairvoyant/method'

module Clairvoyant
  class << self
    # RSPEC describe parser
    #
    # @param description [String] - What we're describing
    #
    # @return [type] [description]
    def describe(description, &block)
      @builder.klass_name ||= description if description.is_a?(Symbol)
      @builder.add_method(description)    if description[0] == '#'
      block.call rescue nil
    end

    # Catch missing constants so we don't hav obscure rescues throughout the
    # code
    #
    # @param name [Symbol] - Name of the undefined constant that was caught
    #
    # @return [Symbol]
    def const_missing(name)
      name
    end

    # Parses a file into a builder
    #
    # @param file_name [String] - Path to the file
    #
    # @return [Clairvoyant::Builder]
    def grok(file_name)
      cleaned_lines =
        File
          .open(file_name, 'r')
          .drop_while { |line| !line.include?('describe') }.join("\n")

      @builder = Clairvoyant::Builder.new

      self.class_eval cleaned_lines

      @builder
    end
  end
end
