require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

get('/') do
  erb(:projects)
end

get('/projects') do
  @project = Project.all
  erb(:projects)
end

get ('/projects/new') do
  erb(:new_project)
end

post ('/projects') do
  title = params[:project_title]
  project = Project.new({:title => title, :id => nil})
  project.save()
  redirect to('/projects')
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end
