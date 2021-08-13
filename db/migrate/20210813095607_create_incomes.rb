class CreateIncomes < ActiveRecord::Migration[5.1]
  def change
    create_table :incomes do |t|
      t.string :income_name
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
