class Quote < ActiveRecord::Base
  attr_accessible :text, :author, :source
  belongs_to :author
end
