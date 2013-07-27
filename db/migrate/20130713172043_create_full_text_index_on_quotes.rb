class CreateFullTextIndexOnQuotes < ActiveRecord::Migration
  def change
    execute "create index on quotes using gin(to_tsvector('english', text));"
  end
end
