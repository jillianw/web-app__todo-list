class Todo < ActiveRecord::Base
  def get_errors
    return @errors
  end

  def set_errors
    @errors = []
    if self.title == ""
      @errors << "Title cannot be blank"
    end
    if self.category_id == nil
      @errors << "Must select a category"
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

  def user_name
    if self.user_id == nil 
      return ""
    else
      x = self.user_id
      y = User.find_by_id(x)
      return y.name
    end
  end
  def category_name
    if self.category_id == nil || ""
      return ""
    else
      x = self.category_id
      y = Category.find_by_id(x)
      return y.name
    end
  end
end