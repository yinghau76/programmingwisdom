class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.text "text"
      t.string "author"
      t.string "source"
      t.timestamps
    end
  end
end
