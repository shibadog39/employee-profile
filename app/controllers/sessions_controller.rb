class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    employee = Employee.find_by(email: session_params[:email])

    if employee&.authenticate(session_params[:password])
      session[:employee_id] = employee.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
