class CreateLargeLineages < ActiveRecord::Migration[6.0]
  def change
    create_table :large_lineages do |t|
      t.string :name
      t.text :description1
      t.text :description2
      t.text :description3

      t.timestamps
    end
  end
end
