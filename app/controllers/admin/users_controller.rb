class Admin::UsersController < ApplicationController
  include ApplicationHelper

  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    authorize([:admin, current_user])
    @users = users_list
  end

  def impersonate
    authorize([:admin, current_user])

    user = User.find(params[:id])
    impersonate_user(user)

    redirect_to plan_subscriptions_path
  end

  def stop_impersonating
    authorize([:admin, true_user])

    stop_impersonating_user

    redirect_to admin_users_path
  end

  private

  # Users with active stripe subscription and those with upcoming deliveries
  def active_users
    Rails.cache.fetch('admin/active_users', expires_in: 5.minutes) do
      Stripe::ActiveSubscriptionsService.active_users.union(User.upcoming_delivery_users)
    end
  end

  def users_list
    @search = params[:search]
    @filter = params[:filter]

    @users = @filter == 'active' ? active_users : User.all
    if @search.present?
      @users = @users.where(
        'concat_ws(first_name, last_name, email) ILIKE ?', "%#{@search}%"
      )
    end
    @users.order(:first_name).page(params[:page])
  end
end
