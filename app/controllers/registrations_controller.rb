class RegistrationsController < Devise::RegistrationsController
  layout 'checkout'

  protected

  def after_inactive_sign_up_path_for(resource)
    page_path('confirm-email', email: resource.email)
  end
end
