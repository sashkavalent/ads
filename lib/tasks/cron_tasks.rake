namespace :events do

  desc 'Rake task to publish ads'
  task :publish => :environment do
    Ad.where(state: 'approved').each do |ad|
      ad.publish
    end
  end

  task :archive => :environment do
    Ad.where(state: 'published').each do |ad|
      ad.archive
    end
  end

  task :test do
    puts "#{Time.now} hello"
  end
end
