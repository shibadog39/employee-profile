module EmployeesHelper
  def fullname e
    e.last_name << ' ' << e.first_name
  end
end
