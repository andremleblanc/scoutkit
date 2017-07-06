class CreateAccountTrackers < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.string :instagram_uid, null: false

      t.timestamps
    end
    add_index :accounts, :instagram_uid, unique: true

    create_table :account_trackers do |t|
      t.references :account, foreign_key: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :account_trackers, [:account_id, :user_id], unique: true
  end
end
