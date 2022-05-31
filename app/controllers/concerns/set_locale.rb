# frozen_string_literal: true

module SetLocale
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def switch_locale(&)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &)
  end
end
