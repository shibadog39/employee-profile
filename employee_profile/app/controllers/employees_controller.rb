class EmployeesController < ApplicationController
  def index
  end

  def show
  end

  def new
    @employee = Employee.new
  end

  def edit
  end

  def create
    employee = Employee.new(employee_params)
    employee.save!
    redirect_to employees_url, notice: "新しく「#{employee.last_name + ' ' + employee.first_name}さん」を登録しました。"
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
