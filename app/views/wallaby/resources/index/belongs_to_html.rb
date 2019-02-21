module Wallaby
  module Resources
    module Index
      class BelongsToHtml < Cell
        def render(object:, field_name:, value:, metadata:) # rubocop:disable Lint/UnusedMethodArgument
          value.present? ? show_link(value, options: { readonly: true }) : null
        end
      end
    end
  end
end