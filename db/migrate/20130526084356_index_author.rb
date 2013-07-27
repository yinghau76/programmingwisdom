class IndexAuthor < ActiveRecord::Migration
  def change
    add_index :quotes, :author_id
  end
end
