class SearchesController < ApplicationController
  def search
  end

  def foursquare

    client_id = ENV['FOURSQUARE_CLIENT_ID']
    client_secret = ENV['FOURSQUARE_SECRET']

    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'VFGYFQC5S0OLTCG523Y0SAUVZK3ONN3KETVKCM5TS0QEXBRN'
      req.params['client_secret'] = 'HNLR1KGY3SD3AVZ5X4FMQ4MYXHWSJHXOB2RQBUDJEAFTHGDD'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)

    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'

    rescue Faraday::TimeoutError
      @error = "There was a timeout. Please try again."
      render 'search'
  end
end
