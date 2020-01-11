require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
require './../config'
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
  erb(:projects)
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

# patch('/projects/:id') do
#
# end

delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.delete()
  erb(:volunteer)
end

get ('/projects/:id/:volunteer_id')do
  @volunteer = Volunteer.find(params[:id].to_i())
  erb(:edit_volunteer)
end

post ('/projects/:id/volunteers')do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:volunteer_name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

patch('/projects/:id/volunteers/:id') do
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.update({:name => params[:name]})
  project_name = params[:project_name]
  erb(:project)
end

delete('/projects/:id/:volunteers/:id') do
  @project = Project.find(params[:id].to_i())
  @volunteer = Volunteer.find(params[:id].to_i())
  @volunteer.delete()
  erb(:project)
end
