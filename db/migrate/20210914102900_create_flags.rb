class CreateFlags < ActiveRecord::Migration[6.1]
  def change
    create_table :flags do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :reason
      t.column :status, :integer, default: 0
      t.references :flaggable, polymorphic: true

      t.timestamps
    end
  end
end
