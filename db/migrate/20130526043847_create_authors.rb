class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
      t.string :name, null: false
      t.timestamps
    end

    Quote.all.each do |quote|
      Author.where(name: quote.author).first_or_create
    end
  end
end
