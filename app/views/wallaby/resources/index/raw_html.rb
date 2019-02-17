module Wallaby
  module Resources
    module Index
      class RawHtml < Cell
        def render(object:, field_name:, value:, metadata:) # rubocop:disable Lint/UnusedMethodArgument
          if value.nil?
            null
          else
            value.html_safe
          end
        end
      end
    end
  end
end
