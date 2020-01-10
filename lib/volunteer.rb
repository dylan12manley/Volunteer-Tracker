class Volunteer
  attr_accessor :name, :id, :project_id

   def initialize(attributes)
     @name = attributes.fetch(:name)
     @id = attributes.fetch(:id)
     @project_id = attributes.fetch(:project_id)
   end

   def ==(volunteer_to_compare)
     self.name() == project_to_compare.name()
   end

 end
