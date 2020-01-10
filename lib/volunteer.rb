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

   def save
     result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
     @id = result.first().fetch("id").to_i
   end

   def self.all
     returned_volunteers = DB.exec("SELECT * FROM volunteers;")
     volunteers = []
     returned_volunteers.each() do | volunteer |
       name = volunteer.fetch("name")
       project_id = volunteer.fetch("project_id").to_i
       id = volunteer.fetch("id").to_i
       volunteers.push(Volunter.new({:name => name, :project_id => project_id, :id => id}))
     end
     volunteers
   end

   def save
     result = DB.exec("INSERT INTO projects (name, project_id) VALUES ('#{@name}', #{@project_id}) RETURNING id;")
     @id = result.first().fetch("id").to_i
   end

   # def self.find(id)
   #   projects = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
   #   name = projects.fetch("name")
   #   id = projects.fetch("id").to_i
   #   Project.new({:name => name, :id => id})
   # end

  #  def update(attributes)
  #    @name = attributes.fetch(:name)
  #    # @id = projects.fetch("id").to_i
  #    DB.exec("UPDATE projects SET name = '#{@name}' WHERE id = #{@id}")
  #    # project = Project.new(attributes)
  #  end
  #
  #  def delete
  #   DB.exec("DELETE FROM projects WHERE id = #{@id};")
  #   DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
  # end

 end
