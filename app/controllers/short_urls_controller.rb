class ShortUrlsController < ApplicationController
  def create
    accepted_params = [:web_url]
    valid_payload = params.permit(accepted_params).to_h

    new_expiry_time = Time.zone.now + 15.minutes
    short_web_url_hex = SecureRandom.hex(8)

    root_url = 'http://127.0.0.1:3000'
    short_web_url = "#{root_url}/#{short_web_url_hex}"

    user = {}
    user = current_user if user_signed_in?

    params = {
      redirect_url: valid_payload[:web_url],
      expire_at: new_expiry_time,
      short_url: short_web_url,
      short_url_uniq_hex: short_web_url_hex,
      status: 'active',
      user_id: user[:id]
    }

    ShortUrl.create!(params)

    redirect_to "/view/#{short_web_url_hex}"
  end

  def view
    valid_params = params.permit(:url_hex).to_h
    @short_url = ShortUrl.find_by( short_url_uniq_hex: valid_params[:url_hex] )
  end

  def show
    short_urls = ShortUrl.where(user_id: current_user[:id])
    required_fields = [:redirect_url, :short_url, :expire_at, :status]

    @result = []
    short_urls.each do |s_url|
      updated_s_url = s_url.slice(*required_fields)
      @result << updated_s_url
    end

    @result
  end

  def redirect_url
    # {"controller"=>"short_urls", "action"=>"redirect_url", "short_url_uniq_hex"=>"690570b5985dfc3e"}
    valid_params = params.permit(:short_url_uniq_hex).to_h
    short_url = ShortUrl.find_by(valid_params)

    # render json: short_url
    puts(short_url.expire_at > Time.zone.now)
    if short_url.expire_at > Time.zone.now
      redirect_to short_url.redirect_url, allow_other_host: true
    else
      flash[:alert] = 'This short URL has expired or is invalid.'
      redirect_to '/url/expired'
    end

  end

  def expired_url
    # This action is empty because it only renders the view
  end
end
