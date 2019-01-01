class EmployeesController < ApplicationController
  helper_method :fullname
  before_action :require_admin, only: [:new, :create, :destroy]

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
    @employee = Employee.new(employee_params)
    set_default_password @employee

    if @employee.save
      redirect_to @employee, notice: "新しく「#{fullname @employee}さん」を登録しました。"
    else
      render :new
    end
  end

  def update
    @employee = Employee.find(params[:id])

    if @employee.update(employee_params)
      redirect_to @employee, notice: "「#{fullname @employee}さん」のプロフィールを更新しました。"
    else
      render :new
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    employee.destroy
    redirect_to employees_url, notice: "「#{fullname employee}さん」を削除しました。"
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin)
  end

  def set_default_password employee
    employee.password = 'password'
    employee.password_confirmation = 'password'
  end

  def fullname e
    @full_name ||= e.last_name << ' ' << e.first_name
  end

  def require_admin
    redirect_to root_path unless login_emp.admin?
  end
end
