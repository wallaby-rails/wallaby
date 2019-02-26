module Wallaby
  # Cell utils
  module CellUtils
    class << self
      # Render a cell and produce output
      # @param context [ActionView::Context]
      # @param file_name [String]
      # @param locals [Hash]
      # @return [String] output
      def render(context, file_name, locals = {}, &block)
        snake_class = file_name[%r{(?<=app/).+(?=\.rb)}].split(SLASH, 2).last
        cell_class = snake_class.camelize.constantize
        Rails.logger.debug "  Rendered [cell] #{file_name}"
        cell_class.new(context, locals).render_complete(&block)
      end

      # Check if a partial is a cell?
      # @param partial_path [String]
      # @return [true] if partial is a `rb` file
      # @return [false] otherwise
      def cell?(partial_path)
        partial_path.end_with? '.rb'
      end
    end
  end
end
