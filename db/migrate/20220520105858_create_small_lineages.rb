class CreateSmallLineages < ActiveRecord::Migration[6.0]
  def change
    create_table :small_lineages do |t|
      t.string :name
      t.text :description1
      t.text :description2
      t.text :description3
      t.integer :medium_lineage_id, index: true

      t.timestamps
    end
  end
end
