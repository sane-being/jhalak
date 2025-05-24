class CreateFollowRequests < ActiveRecord::Migration[8.0]
  def change
    create_table :follow_requests do |t|
      t.boolean :accepted, default: false
      t.references :user, null: false, foreign_key: true
      t.references :follower, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
