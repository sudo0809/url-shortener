class CreateShortUrls < ActiveRecord::Migration[7.0]
  def change
    create_table :short_urls do |t|
      t.text :redirect_url
      t.string :short_url
      t.datetime :expire_at
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
