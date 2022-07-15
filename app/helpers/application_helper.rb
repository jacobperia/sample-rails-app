require 'chronic'

module ApplicationHelper
  def flash_messages_display
    flash_messages_display = []
    flash.each do |key, value|
      flash_messages_display << { key => value } if value.present? && %w[error alert notice success
                                                                         recaptcha_error].include?(key)
    end
    flash_messages_display.reduce(:merge)
  end

  def default_meta_tags
    title = @title || content_for(:page_title) || ''
    description = ''
    image = ''
    {
      'title' => title,
      'description' => description,
      'image' => image,
      'og' => { title: :title, type: 'article', url: request.original_url },
      'twitter' => {
        'card' => 'summary_large_image',
        'site' => '',
        'creator' => '',
        'title' => :title,
        'description' => description,
        'image:src' => image
      }
    }
  end

  def display_price(price)
    ActiveSupport::NumberHelper.number_to_currency(price.to_f / 100, unit: '€')
  end

  def date_display(date)
    return unless date

    Date.parse(date.to_s).strftime('%A, %d %B')
  end

  def time_date_display(timestamp)
    Date.parse(timestamp.to_s).strftime('%A, %d %B, %H:%M')
  end

  # TODO: move these to a service?
  def next_batch_to_cook(current_time = DateTime.now)
    next_wednesday = Chronic.parse('next wednesday 5am', now: current_time).to_date
    next_sunday = Chronic.parse('next sunday 5am', now: current_time).to_date

    # include current day
    today = if current_time.wednesday? || current_time.sunday?
              Chronic.parse(
                'now',
                now: current_time
              ).to_date
            end

    delivery_days = [next_sunday, next_wednesday, today].compact.sort
    delivery_days[0]
  end

  def last_batch_cooked(current_time = DateTime.now)
    last_wednesday = Chronic.parse('last wednesday 5am', now: current_time)
    last_sunday = Chronic.parse('last sunday 5am', now: current_time)

    delivery_days = [last_sunday.to_date, last_wednesday.to_date].sort
    delivery_days.last
  end

  def can_manage_kitchen?(user = current_user)
    user_signed_in? && (user.kitchen? || user.admin?)
  end

  def can_manage_delivery?(user = current_user)
    user_signed_in? && (user.driver? || user.admin?)
  end

  def flash_class(level)
    case level.to_sym
    when :notice then 'alert-info'
    when :success then 'alert-success'
    when :error then 'alert-danger'
    when :alert then 'alert-danger'
    end
  end

  def has_active_subscription?
    user_signed_in? && current_user.has_active_subscription?
  end

  def user_menu_links
    [
      {
        text: 'My Subscriptions',
        icon: 'fe fe-home',
        controller: 'plan_subscriptions',
        action: 'index'
      },
      {
        text: 'billing'
      },
      {
        text: 'Profile',
        icon: 'fe fe-user',
        controller: 'users',
        action: 'edit'
      },
      {
        text: 'Email Preferences',
        icon: 'fe fe-mail',
        controller: 'users',
        action: 'edit_emails'
      },
      {
        text: 'divider'
      },
      {
        text: 'Sign out',
        icon: 'fe fe-log-out',
        controller: 'sessions',
        action: 'destroy'
      }
    ]
  end
end
