class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.integer :telegram_id, null: false
      t.string :given_name, null: false
      t.string :family_name
      t.string :username

      t.timestamps
    end

    add_index(:users, :telegram_id, unique: true, name: :index_users_on_telegram_id)
  end
end
