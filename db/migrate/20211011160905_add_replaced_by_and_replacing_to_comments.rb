class AddReplacedByAndReplacingToComments < ActiveRecord::Migration[6.1]
  def change
    change_table :comments do |t|
      t.belongs_to :replaced_by, null: true, foreign_key: { to_table: :comments }
      t.belongs_to :replacing, null: true, foreign_key: { to_table: :comments }
    end
  end
end
