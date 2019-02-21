module Wallaby
  # A custom lookup context that uses {Wallaby::CellResolver} to find partial
  class CustomLookupContext < ::ActionView::LookupContext
    # It overrides the origin method to wrap paths using {Wallaby::CellResolver}
    # @param paths [Array]
    def view_paths=(paths)
      @view_paths = ActionView::PathSet.new Array(paths).map(&method(:convert))
    end

    # It overrides the oirgin method to call the origin `find_template` and cache the result during a request.
    # @param args [Array]
    def find_template(name, prefixes = [], partial = false, keys = [], options = {})
      prefixes = [] if partial && name.include?(?/)
      key = [name, prefixes, partial, keys, options].map(&:inspect).join('/')
      cached_lookup[key] ||= super
    end

    protected

    # @!attribute [r] cached_lookup
    # Cached lookup result
    def cached_lookup
      @cached_lookup ||= {}
    end

    # Wrap path using {Wallaby::CellResolver}
    # @param path [Object]
    def convert(path)
      case path
      when ActionView::OptimizedFileSystemResolver, Pathname, String
        CellResolver.new path.to_s
      else
        path
      end
    end
  end
end