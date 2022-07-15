class HomeController < ApplicationController
  before_action :intercom_shutdown, only: [:clear_session]

  def index; end

  def clear_session
    redirect_to root_path
  end

  protected

  def intercom_shutdown
    IntercomRails::ShutdownHelper.intercom_shutdown(session, cookies)
  end
end
