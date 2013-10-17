namespace :events do
  desc "Rake task to publish ads"
  task :publish => :environment do
    Ad.where(state: "approved").each do |ad|
      ad.publish
    end
  end
  task :test => :environment do
    puts "#{Time.now} hello"
  end
end
