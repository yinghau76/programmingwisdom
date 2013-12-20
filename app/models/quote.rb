class Quote < ActiveRecord::Base
  belongs_to :author
  validate :possible_duplicated_quote

  def author_name
    author ? author.name : ''
  end

  def possible_duplicated_quote
    longest_word = self.text.gsub(/[!?;,.]/, '').split.group_by(&:size).max.last
    @possible_quotes = Quote.basic_search(longest_word)

    @possible_quotes.each do |quote|
      distance = Text::Levenshtein.distance(text, quote.text)
      if distance < 16
        errors.add(:text, "possibly duplicated to another quote (distance = #{distance}): #{quote.text}")
        break
      end
    end
  end
end
