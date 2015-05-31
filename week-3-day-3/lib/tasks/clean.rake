namespace :clean do
  desc "TODO"
  task prune: :environment do
    ShortenedUrl.prune
  end

end
