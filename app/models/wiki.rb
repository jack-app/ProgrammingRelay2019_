class Wiki < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  before_save :save_body

    def self.search_with(word)
      Wiki.where("title LIKE ?", "%#{word}%")
    end

    def link
      if self.title
        return "/wikis/#{URI.encode(self.title)}"
      end
    end

    def save_body
      real_body = self.body
      puts "fucking chiocolate jesus"
      real_body = add_link(real_body)
      #real_body = 関数(real_body)でできるようにして
      self.update(body: real_body)
    end

    private
    def add_link(body)
      nm = Natto::MeCab.new
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts nm.enum_parse(body)
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
      nm.enum_parse(body).each{|n|
        break if n.is_eos?
        if n.feature.start_with?("名詞") && Wiki.find_by(title: n.surface).present?
          # body = n.feature.start_with?("名詞") && Wiki.find_by(title: n.surface).present?
          puts n
          #ここで書き換えて
        end
      }
      return body
    end
end
