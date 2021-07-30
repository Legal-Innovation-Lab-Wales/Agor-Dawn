class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.string :name, null: false
      t.text :description, null: false
      t.boolean :public, null: false, default: true
      t.integer :view_count, null: false, default: 0
      t.string :summary, null: false, limit: 240
      t.integer :num_likes, null: false, default: 0

      t.timestamps
    end
  end
end
