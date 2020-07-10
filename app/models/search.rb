class Search < ApplicationRecord
  include HTTParty
  validates_uniqueness_of :content, on: :create, message: 'must be unique'

  base_uri 'http://www.omdbapi.com/'

  def shows(params)
    self.class.get(
      "?t=#{params[:title]}&apikey=1e4a60c0&type=#{params[:type]}&y=#{params[:year]}"
    )
  end
end
