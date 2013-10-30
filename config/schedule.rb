set :environment, "development"
set :output, {:error => 'log/cron_error_log.log', :standard => 'log/cron_log.log'}

every 1.day, :at => '24:00' do
  rake 'events:publish'
end

every 1.day, :at => '23:50' do
  rake 'events:archive'
end
