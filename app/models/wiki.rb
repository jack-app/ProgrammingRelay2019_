class Wiki < ApplicationRecord
    def self.search_with(word)
    end

    def link
        "/wikis/#{self.title}"
    end        
end
