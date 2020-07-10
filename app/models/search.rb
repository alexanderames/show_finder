class Search < ApplicationRecord
  include HTTParty
  validates_uniqueness_of :content, on: :create, message: 'must be unique'
  validates_presence_of :title, on: :create, message: 'title is required'

  base_uri 'http://www.omdbapi.com/'

  def shows(params)
    self.class.get(
      "?t=#{params[:title]}&apikey=1e4a60c0&type=#{params[:format]}&y=#{params[:year]}"
    )
  end
end
