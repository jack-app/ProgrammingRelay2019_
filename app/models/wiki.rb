class Wiki < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

    def self.search_with(word)
      Wiki.where("title LIKE ?", "%#{word}%")
    end

    def link
        "/wikis/#{self.title}"
    end

    def save_body(row_body)
      real_body = row_body
      real_body = add_link(real_body)
      #real_body = 関数(real_body)でできるようにして
      self.update(body: real_body)
    end

    private
    def add_link(body)
      nm.enum_parse(body).each{|n|
        break if n.is_eos?
        if n.feature.start_with("名詞") && Wiki.find_by(title: n.surface).present?
          #ここで書き換えて
        end
      }
    end
end
