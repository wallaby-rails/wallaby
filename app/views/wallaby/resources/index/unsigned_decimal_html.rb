module Wallaby
  module Resources
    module Index
      class UnsignedDecimalHtml < Cell
        def render(object:, field_name:, value:, metadata:) # rubocop:disable Lint/UnusedMethodArgument
          value || null
        end
      end
    end
  end
end
