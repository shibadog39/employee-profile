class EmployeesController < ApplicationController
  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def create
    employee = Employee.new(employee_params)
    set_default_password employee
    employee.save!
    redirect_to employees_url, notice: "新しく「#{employee.last_name + ' ' + employee.first_name}さん」を登録しました。"
  end

  def update
    employee = Employee.find(params[:id])
    employee.update!(employee_params)
    redirect_to employees_url, notice: "「#{employee.last_name + ' ' + employee.first_name}さん」のプロフィールを更新しました。"
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def set_default_password employee
    employee.password = 'password'
    employee.password_confirmation = 'password'
  end
end
