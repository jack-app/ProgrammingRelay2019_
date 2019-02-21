class Wiki < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true

    def self.search_with(word)
      Wiki.where("title LIKE ?", "%#{word}%")
    end

    def link
      if self.title
        return "/wikis/#{URI.encode(self.title)}"
      end
    end

    def display_body
      display_body = self.body
      display_body = add_link(display_body)
      #real_body = 関数(real_body)でできるようにして
      return display_body.html_safe
    end

    private
    def add_link(body)
      nm = Natto::MeCab.new
      all_wikis = Wiki.select("title")
      gsub_body = body
      nm.enum_parse(body).each{|n|
        break if n.is_eos?
        if n.feature.start_with?("名詞") && all_wikis.select{|wiki| wiki.title == n.surface}.present?
          gsub_body = gsub_body.gsub(/#{n.surface}/, "<a href='/wikis/#{n.surface}'>#{n.surface}</a>")
        end
      }
      return gsub_body
    end
end
