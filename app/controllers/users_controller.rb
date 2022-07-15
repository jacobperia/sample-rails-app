class UsersController < ApplicationController
  before_action :authenticate_user!, except: :new
  layout 'user_dashboard'

  include ApplicationHelper

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    updated = false
    if user_params[:current_password].present?
      if (user_params[:password].present? ||
        user_params[:password_confirmation].present?) &&
         @user.update_with_password(user_params)
        sign_in @user, bypass: true
        flash[:success] = 'Your password has been successfully updated!'
        updated = true
      else
        flash[:success] = 'Oops something went wrong! Please check your passwords.'
      end
    elsif @user.update_without_password(user_params_without_password)
      flash[:success] = 'Your account has been successfully updated!'
      updated = true
    end

    if updated
      redirect_to account_path
    else
      render :edit
    end
  end

  def edit_emails
    @user = current_user
    render layout: 'user_dashboard'
  end

  def update_emails
    if current_user.update_without_password(params.require(:user).permit(:allow_marketing))
      flash[:success] = 'Your email preferences have been updated!'
      redirect_to email_preferences_path
    else
      render :edit_emails, layout: 'user_dashboard'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :current_password,
      :phone_number,
      :allow_marketing
    )
  end

  def user_params_without_password
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :phone_number,
      :allow_marketing
    )
  end

  def sign_up_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :phone_number,
      :allow_marketing
    )
  end
end
