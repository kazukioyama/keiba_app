class CreateHorses < ActiveRecord::Migration[6.0]
  def change
    create_table :horses do |t|
      t.integer :horse_id
      t.string :name
      t.integer :gender
      t.integer :stable
      t.string :trainer
      t.string :stalion_name
      t.string :mother_name
      t.string :mothers_stalion_name
      t.string :owner_name
      t.string :farm
      t.string :color
      t.datetime :birthday
      t.datetime :erase_date
      t.integer :race_id
      t.integer :bracket_number
      t.integer :post_position
      t.integer :popular_rank
      t.float :odds

      t.timestamps
    end
  end
end
