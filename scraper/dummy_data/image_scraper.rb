require "open-uri"
require 'csv'


def open_images(filepath)
  file = URI.open(filepath)
  article = Article.new(title: "NES", body: "A great console")
  article.photo.attach(io: file, filename: "nes.png", content_)
  article.save
end
