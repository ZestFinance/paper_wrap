# Paper Wrap [![Build Status](https://travis-ci.org/ZestFinance/paper_wrap.png?branch=master)](https://travis-ci.org/ZestFinance/paper_wrap) [![Code Climate](https://codeclimate.com/github/ZestFinance/paper_wrap.png)](https://codeclimate.com/github/ZestFinance/paper_wrap)

![paper_wrap Logo](https://raw.github.com/zestfinance/paper_wrap/master/logo.jpg)

Paper Wrap is a ruby wrapper around the [papertrail](http://papertrailapp.com) http/json API.  PaperWrap provides a clean programmatic layer to allow developers to write functionality in a simple manner on top of the Papertrail API.  PaperWrap is easy-to-use and intuitive, and operates very much like ActiveRecord.

Papertrail's extensive documentation on their http/json API can be found [here](http://help.papertrailapp.com/kb/how-it-works/http-api)

### Contents
0. Installation
1. Getting Started
2. Administer groups
3. Administer saved searches
4. Contribute

### Installation

Add this line to your application's Gemfile

     gem 'paper_wrap', :git => 'https://github.com/ZestFinance/paper_wrap.git'

Then run:

     $ bundle

### Getting Started

To initialize the API wrapper, create a PaperWrap::Settings object and set that into PaperWrap.settings.  This will set the username and password for all queries / updates via the papertrail API.

```ruby

 require 'paper_wrap'
 # given: user, password (username and password for papertrail
 config_settings = PaperWrap::Settings.new(username: user, password: pass)
 PaperWrap.settings = config_settings

```

### Working with Papertrail Groups


```ruby

 # Retrieve a specific group by name
 group = PaperWrap::Group.find_by_group_name('production-systems')
 puts "name of group: #{group.name}"
 puts "id of group:   #{group.id}"
 puts "group match:   #{group.system_wildcard}"

 # Create a new group in Papertrail
 group = PaperWrap::Group.create(name: "qa-systems", system_wildcard: "qa-*")

```

### Working with Saved Searches

Saved searches in papertrail allow users to re-run queries against papertrail later.  The saved search API gives developers a number of administration options.

```ruby

 #  Retrieve a specific search by its name 
 saved_searches = PaperWrap::Search.find_by_name('production-timeouts')
 saved_searches.each do |search|     
    #  saved search parameters
    puts "id:    #{search.id}"   
    puts "name:  #{search.name}"
    puts "query: #{search.query}"
    #  every search belongs to a group in papertrail
    puts "group id:   #{search.group_id}"
    puts "group name: #{search.group_name}"
 end

 # Retrieves all saved searches that belong to a particular group
 saved_searches_for_group = PaperWrap::Search.find_all_by_group_name('production-cluster-A')
 
 #  Move a list of saved searches to a new group
 new_group #  retrieve new group via the PaperWrap group API
 saved_searches_for_group.each do |search|
   search.move_to_group(new_group)
 end

```

### Contribute

There is much more functionality available via the Papertrail http/json API not yet implemented.  Please feel free to fork this project and submit your additions.  Contributing to open-source projects helps everyone!

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a pull request

