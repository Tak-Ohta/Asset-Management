class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.date :birthday
      t.string :sex
      t.string :prefecture
      t.string :occupation
      t.string :marriage
      t.string :children
      t.string :annual_income

      t.timestamps
    end
  end
end
