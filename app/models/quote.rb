class Quote < ActiveRecord::Base
  attr_accessible :text, :author, :source
  belongs_to :author

  def author_name
    author ? author.name : ''
  end
end
