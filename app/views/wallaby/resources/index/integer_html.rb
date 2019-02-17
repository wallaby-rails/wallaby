module Wallaby
  module Resources
    module Index
      class IntegerHtml < Cell
        def render(object:, field_name:, value:, metadata:) # rubocop:disable Lint/UnusedMethodArgument
          value.try(:to_i) || null
        end
      end
    end
  end
end
