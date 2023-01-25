class ApplicationController < ActionController::API
    around_action :switch_locale

    def switch_locale(&action)
        # Switch to the locale sent in the params
        # or the default locale if no locale is sent
        # Example: http://localhost:3000/?locale=pt-BR
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale, &action)
    end
end
