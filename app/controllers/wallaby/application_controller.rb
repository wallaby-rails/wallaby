module Wallaby
  # Wallaby's application controller. Like ordinary Rails application, it's the base controller that
  # other Wallaby controllers inherit from. However, the difference is that the controller class that
  # `Wallaby::ApplicationController` inherits from can be configured via {Wallaby::Configuration#base_controller}
  #
  # Here, it provides the most basic functions e.g. error handling for common 4xx HTTP status, helpers method,
  # and URL handling.
  class ApplicationController < configuration.base_controller
    extend Engineable::ClassMethods
    include Engineable
    include SharedHelpers
    helper ApplicationHelper

    self.responder = ActionController::Responder
    respond_to :html

    rescue_from NotFound, with: :not_found
    rescue_from ::ActionController::ParameterMissing, with: :bad_request
    rescue_from ::ActiveRecord::StatementInvalid, with: :unprocessable_entity
    rescue_from UnprocessableEntity, with: :unprocessable_entity

    delegate(*ConfigurationHelper.instance_methods, :url_for, to: :helpers)

    # Health check page for e.g. NewRelic
    def healthy
      render plain: 'healthy'
    end

    # Not found page
    # @param exception [Exception, nil] exception comes from `rescue_from`
    def not_found(exception = nil)
      error_rendering exception, __callee__
    end

    # Bad request page
    # @param exception [Exception, nil] exception comes from `rescue_from`
    def bad_request(exception = nil)
      error_rendering exception, __callee__
    end

    # Unprocessable entity page
    # @param exception [Exception, nil] exception comes from `rescue_from`
    def unprocessable_entity(exception = nil)
      error_rendering exception, __callee__
    end

    # Internal server error page
    # @param exception [Exception, nil] exception comes from `rescue_from`
    def internal_server_error(exception = nil)
      error_rendering exception, __callee__
    end

    # `helpers` exists since Rails 5, need to mimic this for Rails 4.2
    # @see https://github.com/rails/rails/blob/5-0-stable/actionpack/lib/action_controller/metal/helpers.rb#L118
    def helpers
      @helpers ||= defined?(super) ? super : view_context
    end

    protected

    # Capture exceptions and display the error using error layout and template.
    # @param exception [Exception]
    # @param symbol [Symbol] http status symbol
    def error_rendering(exception, symbol)
      Rails.logger.error exception

      @exception = exception
      @symbol = symbol
      @code = Rack::Utils::SYMBOL_TO_STATUS_CODE[symbol].to_i
      respond_with @exception, status: @code, template: ERROR_PATH, prefixes: _prefixes
    end
  end
end
