class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :title
      t.string :year
      t.string :format
      t.jsonb :content

      t.timestamps
    end
  end
end
