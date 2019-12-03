# frozen_string_literal: true

module Wallaby
  module Resources
    module Index
      # Html cell
      class UnsignedIntegerHtml < Cell
        # @return [String]
        def render
          value.try(:to_i) || null
        end
      end
    end
  end
end
