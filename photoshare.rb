require 'sinatra'
require 'Unirest'

get '/' do 
	@title = 'Photos'
	@photos = recent_photos
	erb :all_photos
end

	def recent_photos (hashtag = "goals", resolution = "thumbnail")
		@photos = []
		instagram_response = "https://api.instagram.com/v1/tags/#{hashtag}/media/recent?client_id=8d25f557eedb478a81df25773ffd06b8"
		response = Unirest.get(instagram_response)
		photos_array = response.body["data"]

		photos_array.each do |photo|
			image = photo["images"][resolution]["url"]
			@photos << image
		end
		@photos
	end




get '/:resolution/:hashtag' do 
	@title = 'Photos'
	@photos = recent_photos(params[:hashtag],params[:resolution])
	erb :all_photos
end