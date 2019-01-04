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
    @edit_profile =  params[:edit_profile]
    @employee = Employee.find(params[:id])
    require_yourself @employee
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
    require_yourself @employee

    if @employee.update(employee_params)
      redirect_to @employee, notice: "「#{fullname @employee}さん」のプロフィールを更新しました。"
    else
      render :edit
    end
  end

  def destroy
    employee = Employee.find(params[:id])
    redirect_to root_path, notice: "自分のことを削除することはできません。" if login_emp.id == employee.id
    employee.destroy
    redirect_to employees_url, notice: "「#{fullname employee}さん」を削除しました。"
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :password, :password_confirmation, :admin, :team, :hobby, :comment)
  end

  def set_default_password employee
    employee.password = 'password'
    employee.password_confirmation = 'password'
  end

  def fullname e
    #ボツ案 破壊的メソッドだから繰り返し呼ばれたときに名前が伸びていく
    #e.last_name << ' ' << e.first_name

    #冗長すぎて嫌な案
    #str = ''
    #str << e.last_name
    #str << ' '
    #str << e.first_name

    #行けるけどいいのか微妙案
    e.last_name + ' ' + e.first_name
  end

  def require_admin
    redirect_to root_path unless login_emp.admin?
  end

  def require_yourself emp
    redirect_to root_path unless login_emp.id == emp.id
  end
end
