FactoryBot.define do
  factory :search do
    title { 'pulp fiction' }
    year { '1994' }
    format { 'movie' }
    content do
      {
        Faker::Movie.title => Faker::Movie.quote
      }
    end
  end
end
