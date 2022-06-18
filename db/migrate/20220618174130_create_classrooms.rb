class CreateClassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :classrooms do |t|
      t.string :name

      t.timestamps
    end
    create_table :classrooms_users do |t|
      t.belongs_to :classroom
      t.belongs_to :user
    end
  end
end
