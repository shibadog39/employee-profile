class AddProfileToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :team, :string
    add_column :employees, :hobby, :string
    add_column :employees, :comment, :text
  end
end
