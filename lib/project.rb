class Project
  attr_accessor :title, :id

   def initialize(attributes)
     @title = attributes.fetch(:name)
     @id = attributes.fetch(:id)
   end

 end
