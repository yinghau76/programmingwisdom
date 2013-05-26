class AssociateQuoteWithAuthor < ActiveRecord::Migration
  def change
    add_column(:quotes, :author_id, :integer)

    Quote.all.each do |quote|
      if quote.author
        author = Author.where(name: quote.author).first
        execute("UPDATE quotes SET author_id = #{author.id} WHERE id = #{quote.id}")
      end
    end

    remove_column(:quotes, :author)
  end
end
