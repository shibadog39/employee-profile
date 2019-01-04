class CreateWorkHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :work_histories do |t|
      t.references :employee, foreign_key: true
      t.string :company
      t.string :team
      t.string :mission
      t.float :year
      t.timestamps
    end
  end
end
