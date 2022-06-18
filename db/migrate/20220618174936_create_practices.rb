class CreatePractices < ActiveRecord::Migration[7.0]
  def change
    create_table :practices do |t|
      t.date :day

      t.timestamps
    end
  end
end
