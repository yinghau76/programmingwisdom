class Quote < ActiveRecord::Base
  attr_accessible :text, :author, :source
end
