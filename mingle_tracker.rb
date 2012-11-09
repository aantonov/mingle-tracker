require 'optparse'
require File.expand_path("./lib/mingle_client", File.dirname(__FILE__))
require File.expand_path("./lib/utils", File.dirname(__FILE__))
require File.expand_path("./lib/card_viewer", File.dirname(__FILE__))
require 'yaml'

OPTS = YAML.load_file("./conf/mingle-cli.conf.yml")

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: #{__FILE__} [OPTIONS]"
  opt.separator ""
  opt.separator "Options:"

  opt.on("-a" ,"--all", "Show all mingle cards") do
    options[:all] = true
  end

  opt.on("-s" ,"--story [STATUS]", "Show story cards. If STATUS isn't specified, stories with all statuses will be showed") do |status|
    options[:story] = true
    options[:status] = status
  end

  opt.on("-t" ,"--task [STATUS]", "Show task cards. If STATUS isn't specified, tasks with all statuses will be showed") do |status|
    options[:task] = true
    options[:status] = status
  end

  opt.on("-d" ,"--defect [STATUS]", "Show defect cards. If STATUS isn't specified, defects with all statuses will be showed") do |status|
    options[:defect] = true
    options[:status] = status
  end

  opt.on("-u", "--user [USERNAME]", "Show cards for specified owner. If USERNAME isn't specified, current user cards will be showed") do |username|
    options[:user] = true
    options[:username] = username
  end

  opt.on("--sprint [SPRINT_ID]", "Show cards for specified sprint") do |sprint_id|
    options[:sprint] = true
    options[:sprint_id] = sprint_id
  end

  opt.on("-h", "--help", "Show this message") do
    options[:help] = true
    puts opt_parser
  end

  opt.separator ""
  opt.separator "Examples:"
  opt.separator "#{__FILE__} -a                      #shows all cards for current sprint"
  opt.separator "#{__FILE__} -a -u                   #shows all cards for current user"
  opt.separator "#{__FILE__} -d                      #shows all defects for current sprint"
  opt.separator "#{__FILE__} -d --sprint \"7\"         #shows all defects for specified sprint"
  opt.separator "#{__FILE__} -d -u \"John Smith\"      #shows defects owned by John's"
  opt.separator "#{__FILE__} -a --sprint \"7\"         #shows all cards for specified sprint"
end

opt_parser.parse!

mingle = MingleClient.new(OPTS["mingle"]["url"], OPTS["mingle"]["username"], OPTS["mingle"]["password"])

filter = CardsFilter.new
story_filter = CardsFilter.new
task_filter = CardsFilter.new

cards = []

if options[:all]
  filter.defect

  story_filter.story
  task_filter.task
end

if options[:story]
  filter.story(options[:status])
end

if options[:task]
  filter.task(options[:status])
end

if options[:defect]
  filter.defect(options[:status])
end

if options[:user]
  if options[:username]
    filter.user(options[:username])
    story_filter.user(options[:username])
    task_filter.user(options[:username])
  else
    filter.user
    story_filter.user
    task_filter.user
  end
end

if options[:sprint]
  if options[:sprint_id]
    filter.sprint(options[:sprint_id])
  else
    filter.sprint
  end
end

if not options[:help]

  if options[:all]
    cards = mingle.get_cards(story_filter.filter)
    cards += mingle.get_cards(task_filter.filter)
  end

  cards += mingle.get_cards(filter.filter)
  CardViewer.new.view_cards(cards)
end