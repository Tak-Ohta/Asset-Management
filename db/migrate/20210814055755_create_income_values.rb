class CreateIncomeValues < ActiveRecord::Migration[5.1]
  def change
    create_table :income_values do |t|
      t.date :year_month
      t.float :income_value
      t.string :description
      t.references :income, foreign_key: true

      t.timestamps
    end
  end
end
