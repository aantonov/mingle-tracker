

class Card
  attr_accessor :id, :number, :name, :description, :type, :status, :task_points, :hours_remaining, :sprint, :story, :owner
end

class StoryStatus
  READY_FOR_ANALYSIS = "Ready for Analysis"
  IN_ANALYSIS = "In Analysis"
  READY_FOR_DEVELOPMENT = "Ready for Development"
  IN_DEVELOPMENT = "In Development"
  ACCEPTED = "Accepted"
  ALL = ""
end

class TasksStatus
  NEW = "New"
  IN_PROGRESS = "In progress"
  DONE = "Done"
  ALL = ""
end

class DefectStatus
  NEW = "New"
  IN_PROGRESS = "Fix in progress"
  FIXED = "Fixed"
  CLOSED = "Closed"
  ALL = ""
end

class CardsFilter

  def initialize()
    @filter = "?"
  end

  def filter()
    @filter
  end

  def add_filter(filter)
    @filter = @filter + "&" + filter
    self
  end

  def story(status = StoryStatus::ALL)
    @filter = @filter + "&filters[]=[Type][is][Story]"
    if not status.eql?(nil) and not status.eql?("")
      @filter = @filter + "&filters[]=[Status][is][#{status}]"
    end
    self
  end

  def task(status = TasksStatus::ALL)
    @filter = @filter + "&filters[]=[Type][is][Task]"
    if not status.eql?(nil) and not status.eql?("")
      @filter = @filter + "&filters[]=[Task Status][is][#{status}]"
    end
    self
  end

  def defect(status = DefectStatus::ALL)
    @filter = @filter + "&filters[]=[Type][is][Defect]"
    if not status.eql?(nil) and not status.eql?("")
      @filter = @filter + "&filters[]=[Defect Status][is][#{status}]"
    end
    self
  end

  def sprint(sprint = "(Current Sprint)")
    @filter.slice!("filters[]=[Sprint][is][(Current Sprint)]")
    @filter = @filter + "&filters[]=[Sprint][is][#{sprint}]"
    self
  end

  def user(username = "current user")
    if not username.eql?("current user")
      username = username.downcase.gsub(/ /, '.')
    end
    @filter = @filter + "&filters[]=[Owner][is][#{username}]"
    self
  end
end
