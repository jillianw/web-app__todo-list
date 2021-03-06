class Category < ActiveRecord::Base
  def get_errors
    return @errors
  end

  def set_errors
    @errors = []
    if self.name == ""
      @errors << "Name cannot be blank"
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
    x = self.id 
    y = Todo.find_by_id(x)
    return y.title
  end
end