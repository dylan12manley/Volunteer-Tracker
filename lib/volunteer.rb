class Volunteer
  attr_accessor :name, :id, :project_id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end

  def ==(volunteer_to_compare)
    if volunteer_to_compare != nil
      @name == volunteer_to_compare.name && @project_id == volunteer_to_compare.project_id && @id == volunteer_to_compare.id
    else
      false
    end
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
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.find(id)
    volunteers = DB.exec("SELECT * FROM volunteers WHERE id = #{id};").first
    # name = volunteers.fetch("name")
    # project_id = volunteers.fetch("project_id").to_i
    # id = volunteers.fetch("id").to_i
    Volunteer.new({:name => name, :project_id => project_id, :id => id})
  end

  def self.find_by_project(proj_id)
    volunteer_array = []
    volunteers = DB.exec("SELECT * FROM volunteers WHERE project_id = #{proj_id};")
    volunteers.each() do | volunteer |
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id").to_i
      id = volunteer.fetch("id").to_i
      volunteer_array.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteer_array
  end

  def update(attr)
    if attr[:name] = nil
      @name = attr[:name]
    else @name = name
    end
    DB.exec("UPDATE volunteers SET name = '#{@name}' WHERE id = #{@id};")
  end

end
