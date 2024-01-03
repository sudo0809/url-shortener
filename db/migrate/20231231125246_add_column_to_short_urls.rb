class AddColumnToShortUrls < ActiveRecord::Migration[7.0]
  def change
    add_column :short_urls, :short_url_uniq_hex, :string
  end
end
