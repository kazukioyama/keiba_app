class CreateStalions < ActiveRecord::Migration[6.0]
  def change
    create_table :stalions do |t|
      t.string :name, index: true, index: true
      t.integer :small_lineage_id, index: true
      t.integer :medium_lineage_id, index: true

      t.timestamps
    end
  end
end
