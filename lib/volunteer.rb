class Volunteer
  attr_accessor :title, :id, :project_id

   def initialize(attributes)
     @title = attributes.fetch(:name)
     @id = attributes.fetch(:id)
     @project_id = attributes.fetch(:project_id)
   end

 end
