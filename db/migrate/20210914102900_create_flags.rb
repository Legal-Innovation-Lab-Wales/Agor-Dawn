class CreateFlags < ActiveRecord::Migration[6.1]
  def change
    create_table :flags do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :reason
      t.boolean :admin_resolved, null: false, default: false
      t.boolean :user_resolved, null: false, default: false
      t.references :flaggable, polymorphic: true

      t.timestamps
    end
  end
end
