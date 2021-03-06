
# Path helpers
module NavigationHelpers
  def path_to(page_name)
    case page_name
      when /^the admin page/
        admin_path
      when /^the courses page/
        courses_path
      else
        raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end

end

World(NavigationHelpers)