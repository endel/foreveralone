def pwd
  File.expand_path('.')
end

every '*/30 * * * *' do
  command "cd #{pwd} && heroku run:rake robot"
end
