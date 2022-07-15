class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :layout_by_resource

  impersonates :user

  include Pundit
  before_action :store_current_location, unless: :devise_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_meta_properties, unless: -> { request.format.json? }
  before_action :set_paper_trail_whodunnit, if: :user_signed_in?

  if Rails.env.development? && ENV['LOCAL_TIME'].present?
    # !!! For testing only!
    Timecop.travel(Chronic.parse(ENV['LOCAL_TIME']))
  end

  rescue_from Pundit::NotAuthorizedError do
    flash[:alert] = "Oops! Looks like you aren't allowed to do this..."
    redirect_back(fallback_location: root_path)
  end

  def set_meta_properties(*args)
    title = args[0] && args[0][:title] ? args[0][:title] : nil
    description = if args[0] && args[0][:description] && !args[0][:description].empty?
                    truncate(
                      strip_tags(args[0][:description]), length: 155, separator: ' '
                    )
                  end
    description = description.squish if description
    image = args[0] && args[0][:image] ? URI.join(request.url, args[0][:image]) : nil

    set_meta_tags title: title if title
    set_meta_tags description: description if description
    set_meta_tags image: image if image
    set_meta_tags og: { title: title, description: description, image: image } if title

    if title || description || image
      set_meta_tags twitter: {
        'title' => title,
        'description' => description,
        'image:src' => image
      }
    end

    if args[0] && args[0][:canonical]
      full_url = if args[0][:canonical].include? 'http'
                   rgs[0][:canonical]
                 else
                   'http://' + (
                     request.host ||
                     Rails.application.credentials.dig(:host, :domain) ||
                     ENV['host']
                   ) + args[0][:canonical]
                 end
      set_meta_tags canonical: full_url
      set_meta_tags og: { url: full_url }
    end
  end

  protected

  def layout_by_resource
    if devise_controller? || params[:controller] == 'registrations'
      if params[:controller] == 'devise/registrations' && (params[:action] == 'edit' || params[:action] == 'update')
        'user_dashboard'
      else
        'devise'
      end
    else
      'application'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name email password password_confirmation phone_number
                                               address city county allow_marketing])
  end

  def user_for_paper_trail
    true_user.id
  end

  private

  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to new_user_registration_path, notice: 'To continue, please sign up or sign in.'
    end
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end

  def store_current_location
    store_location_for(:user, request.url)
  end

  def after_sign_out_path_for(_resource)
    # request.referrer || root_path
    clear_session_path
  end
end
