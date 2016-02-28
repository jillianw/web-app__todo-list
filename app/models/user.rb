class User < ActiveRecord::Base
  def get_errors
    return @errors
  end

  def set_errors
    @errors = []
    if self.name == ""
      @errors << "Name cannot be blank"
    end
    if self.email == ""
      @errors << "Email cannot be blank"
    end
    if self.password == ""
      @errors << "Password cannot be blank"
    end
  end

  def is_valid
    self.set_errors
    if @errors.length > 0
      return false
    else
      return true
    end
  end

  def todo_lists
    Todo.find_by_id(self.id).title #NOT WORKING
  end
end

