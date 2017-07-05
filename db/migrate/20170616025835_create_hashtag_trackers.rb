class CreateHashtagTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :hashtag_trackers do |t|
      t.references :hashtag, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false

      t.timestamps
    end
    add_index :hashtag_trackers, [:hashtag_id, :user_id], unique: true
  end
end
