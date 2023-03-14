require "open-uri"

file = URI.open("https://upload.wikimedia.org/wikipedia/comm")
article = Article.new(title: "NES", body: "A great console")
article.photo.attach(io: file, filename: "nes.png", content_)
article.save
