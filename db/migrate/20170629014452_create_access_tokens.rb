class CreateAccessTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :access_tokens do |t|
      t.references :user, foreign_key: true, null: false
      t.string :encrypted_value, null: false
      t.string :encrypted_value_iv, null: false

      t.timestamps
    end
  end
end
