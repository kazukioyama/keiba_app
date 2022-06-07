class CreateRaceCourseEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :race_course_events do |t|
      t.integer :race_course_id, index: true
      t.integer :distance, index: true
      t.text :description

      t.timestamps
    end
  end
end
