class CreateMediumLineages < ActiveRecord::Migration[6.0]
  def change
    create_table :medium_lineages do |t|
      t.string :name
      t.text :description1
      t.text :description2
      t.text :description3
      t.integer :large_lineage_id, index: true

      t.timestamps
    end
  end
end
