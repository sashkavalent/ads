set :environment, "development"
set :output, {:error => 'log/cron_error_log.log', :standard => 'log/cron_log.log'}

every 1.day, :at => '10:07 pm' do
  rake 'events:publish'
end

every 1.day, :at => '10:07 pm' do
  rake 'events:archive'
end
