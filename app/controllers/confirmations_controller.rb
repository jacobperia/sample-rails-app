class ConfirmationsController < Devise::ConfirmationsController
  protected

  def after_confirmation_path_for(_resource_name, resource)
    sign_in(resource)
    plan_subscriptions_path
  end
end
