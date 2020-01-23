require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')

DB = PG.connect({:dbname => "volunteer_tracker"})
also_reload('lib/**/*.rb')

get('/') do
  redirect to '/projects'
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post ('/projects') do
  title = params[:title]
  Project.new({:title => title, :id => nil}).save
  redirect to '/projects'
end

get ('/projects/new') do
  erb(:new_project)
end

get ('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  erb(:project)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i())
  erb(:edit_project)
end

patch('/projects/:id') do
  title = params[:title]
  Project.find(params[:id].to_i).update({:title => title})
  redirect to "/projects/#{params[:id]}"
end

delete ('/projects/:id') do
  @project = Project.find(params[:id].to_i).delete
  redirect to '/projects'
end

post ('/projects/:id') do
    volunteer_name = params[:volunteer_name]
    proj_id = params[:id]
    Volunteer.new({:name => volunteer_name, :project_id => proj_id, :id => nil}).save
    redirect to "/projects/#{params[:id]}"
end

patch('/projects/:id') do
  project_title = params[:project_name]
  Project.find(params[:id].to_i).update({:title => project_title})
  # @volunteer = Volunteer.find(params[:id].to_i())
  # @volunteer.update({:name => params[:name]})
  erb(:project)
end

get '/projects/:id/volunteers/:volunteer_id' do
    @volunteer = Volunteer.find(params[:volunteer_id].to_i)
    @project = Project.find(params[:id].to_i)
    erb (:volunteer)
end
post ('/projects/:id/volunteers/:volunteer_id')do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

post ('/projects/:id/volunteers')do
  @project = Project.find(params[:id].to_i())
  volunteer = Volunteer.new({:name => params[:name], :project_id => @project.id, :id => nil})
  volunteer.save()
  erb(:project)
end

patch('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i())
  Volunteer.find(params[:volunteer_id].to_i).update(:volunteer_name)
  redirect to "/projects/#{params[:id]}"
end
# patch('/projects/:id/volunteers/:volunteer_id') do
#   @volunteer = Volunteer.find(params[:id].to_i())
#   @volunteer.update({:name => params[:name]})
#   project_name = params[:project_name]
#   erb(:project)
# end

patch ('/projects/:id/volunteers/:volunteer_id') do
    # volunteer_name = params[:volunteer_name]
    @project = Project.find(params[:id].to_i())
    Volunteer.find(params[:volunteer_id].to_i).update(:volunteer_name)
    redirect to "/projects/#{params[:id]}"
end

delete('/projects/:id/:volunteers/:volunteer_id') do
  Volunteer.find(params[:id].to_i()).delete
  @project = Project.find(params[:id].to_i())
  erb(:project)
end
