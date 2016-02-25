class Todo < ActiveRecord::Base
  def get_errors
    return @errors
  end

  def set_errors
    @errors = []
    if self.title == ""
      @errors << "Title cannot be blank"
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
end