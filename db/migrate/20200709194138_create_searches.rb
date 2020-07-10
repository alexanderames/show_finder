class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :title
      t.string :year
      t.string :type
      t.json :content

      t.timestamps
    end
  end
end
