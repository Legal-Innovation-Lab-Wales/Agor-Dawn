class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :comment_text
      t.belongs_to :project, null: false, foreign_key: true
      t.belongs_to :replaced_by, null: true, foreign_key: { to_table: :comments }
      t.belongs_to :replacing, null: true, foreign_key: { to_table: :comments }

      t.timestamps
    end
  end
end
