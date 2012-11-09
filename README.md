mingle-tracker
==============

Simple console tool for tracking tasks in Mingle


# Prerequisites
* Ruby 1.8.7
* Rubygems
* rest_client gem
* rexml gem

# Installation

	cd <your directory>
	git clone https://github.com/aantonov/mingle-tracker.git
	cd mingle-tracker
	chmod 755 mingle_tracker.rb
	vim ./conf/mingle-cli.conf.yml              #change configuration file. Set up Mingle API url, your login and password
	

#How to use

	./mingle-tracker.rb -a                      #shows all cards"
    ./mingle-tracker.rb -a -u                   #shows all cards for current user"
    ./mingle-tracker.rb -d --sprint             #shows all defects for current sprint"
    ./mingle-tracker.rb -d --sprint "7"         #shows all defects for specified sprint"
    ./mingle-tracker.rb -d -u "John Smith"      #shows defects owned by John's"
    ./mingle-tracker.rb -a --sprint "7"         #shows all cards for specified sprint"
    ./mingle-tracker.rb -h                      #shows help