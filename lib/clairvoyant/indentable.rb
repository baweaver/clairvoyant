module Clairvoyant
  module Indentable
    # Generates spacing for indentation
    #
    # @param times = 1 [Integer] - Number of indents to render
    #
    # @return [String]
    def indent(times = 1)
      ' ' * (@indentation * times)
    end
  end
end
