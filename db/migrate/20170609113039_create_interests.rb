class CreateInterests < ActiveRecord::Migration[5.0]
  def change
    create_table :interests do |t|
      t.integer :person_id
      t.integer :course_id

      t.timestamps
    end
  end
end
