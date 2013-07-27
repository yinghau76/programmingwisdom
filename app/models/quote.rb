class Quote < ActiveRecord::Base
  belongs_to :author

  def author_name
    author ? author.name : ''
  end
end
