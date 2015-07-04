module Clairvoyant
  class Method
    include Indentable

    attr_reader :name

    def initialize(name:, indentation: 2)
      @name        = name
      @indentation = indentation
    end

    # Formats a method as a ruby method
    #
    # @return [String]
    def to_s
      "#{indent(1)}def #{name}\n" <<
        "#{indent(2)}# Code here later\n" <<
      "#{indent(1)}end"
    end
  end
end
