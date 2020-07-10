require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'shows search', :vcr do
    subject(:search) do
      described_class.new(title: 'batman', content: { 'foo' => 'bar' })
    end

    it 'is valid with a title' do
      expect(subject).to be_valid
    end

    it 'is not valid without a title' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    context 'when content is not unique' do
      before do
        described_class.create!(title: 'batman', content: { 'foo' => 'bar' })
      end
      it { expect(subject).to be_invalid }
    end

    context 'scopes' do
      let!(:search1) { create(:search) }
      let!(:search2) { create(:search, title: 'zodiac') }

      it 'default sort by ascending name' do
        expect(Search.all).to eq([search1, search2])
      end

      it 'filter by name' do
        expect(Search.all.title_contains('zodiac')).to eq([search2])
      end
    end

    let(:params) do
      { title: 'fargo' }
    end

    let(:shows) { search.shows(params) }

    it 'returns httparty parsed response' do
      expect(shows.parsed_response).to eq('Title' => 'Fargo',
                                          'Year' => '1996',
                                          'Rated' => 'R',
                                          'Released' => '05 Apr 1996',
                                          'Runtime' => '98 min',
                                          'Genre' => 'Crime, Drama, Thriller',
                                          'Director' => 'Joel Coen, Ethan Coen',
                                          'Writer' => 'Ethan Coen, Joel Coen',
                                          'Actors' => 'William H. Macy, Steve Buscemi, Peter Stormare, Kristin Rudrüd',
                                          'Plot' => "Jerry Lundegaard's inept crime falls apart due to his and his henchmen's bungling and the persistent police work of the quite pregnant Marge Gunderson.",
                                          'Language' => 'English',
                                          'Country' => 'USA, UK',
                                          'Awards' => 'Won 2 Oscars. Another 81 wins & 57 nominations.',
                                          'Poster' => 'https://m.media-amazon.com/images/M/MV5BNDJiZDgyZjctYmRjMS00ZjdkLTkwMTEtNGU1NDg3NDQ0Yzk1XkEyXkFqcGdeQXVyNzkwMjQ5NzM@._V1_SX300.jpg',
                                          'Ratings' => [{ 'Source' => 'Internet Movie Database', 'Value' => '8.1/10' },
                                                        { 'Source' => 'Rotten Tomatoes', 'Value' => '94%' },
                                                        { 'Source' => 'Metacritic', 'Value' => '85/100' }],
                                          'Metascore' => '85',
                                          'imdbRating' => '8.1',
                                          'imdbVotes' => '595,812',
                                          'imdbID' => 'tt0116282',
                                          'Type' => 'movie',
                                          'DVD' => '24 Jun 1997',
                                          'BoxOffice' => 'N/A',
                                          'Production' => 'Gramercy Pictures',
                                          'Website' => 'N/A',
                                          'Response' => 'True')
    end
  end
end
