class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: true, index: true, comment: 'team.id'
      t.string :body, null: false, index: false, default: '', comment: '内容'

      t.timestamps
    end
  end
end
