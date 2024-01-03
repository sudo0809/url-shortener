namespace :remove_data do
  desc 'for user'
  task remove_short_urls: :environment do
    user = User.where(email: 'sugatdhole@gmail.com').take

    url_ids = user.short_urls.pluck(:id)

    response = ShortUrl.delete(url_ids)
    puts response
  end
end