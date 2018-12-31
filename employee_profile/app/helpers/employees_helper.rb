module EmployeesHelper
  def fullname e
    @full_name ||= e.last_name << ' ' << e.first_name
  end
end
