class ApplicationController < ActionController::Base
  helper_method :login_emp
  before_action :login_required

  private

  def login_emp
    @login_emp ||= Employee.find_by(id: session[:employee_id]) if session[:employee_id]
  end

  def login_required
    redirect_to login_path unless login_emp
  end
end
