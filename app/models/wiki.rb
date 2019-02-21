class Wiki < ApplicationRecord
    def self.search_with(word)
      Wiki.where("title LIKE ?", "%#{word}%")
    end

    def link
        "/wikis/#{self.title}"
    end
end
