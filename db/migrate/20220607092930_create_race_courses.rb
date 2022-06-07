class CreateRaceCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :race_courses do |t|
      t.string :name, index: true
      t.text :description

      t.timestamps
    end
  end
end
