class Wiki < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

    def self.search_with(word)
      Wiki.where("title LIKE ?", "%#{word}%")
    end

    def link
        "/wikis/#{self.title}"
    end
end
