---
layout: post
title: Taming a Capybara
date: 26 July 2011
---

<div class="align_center">
  <img src="/images/capybara.jpg" title="Rude Capybara" alt="Rude Capybara"/>
  <br/>
  <a href="http://raxdakkar.com/2009/06/28/capybara-as-a-pet-i-want-one/">
    <small>photo from raxdakkar.com</small>
  </a>
</div>

<br/>

Running acceptance tests in our rails 3 application turned out to be non
trivial, even though there are excellent tools out there, and they keep
getting better.

We are currently using [capybara](https://github.com/jnicklas/capybara)
with the [capybara-webkit driver](https://github.com/thoughtbot/capybara-webkit),
which is great because it runs in headless mode, without annoying
browser windows popping up. I heard the QT download can be pretty big
for mac users though, so have some spare bandwidth around if you have a
mac and are planning to give it a try.

As we kept adding tests, the size of our **spec/support/capybara.rb**
file grew with a lot of hacks. Here is an anotated version of that file
and some others related, should it be helpful to anybody out there.
Perhaps somebody will want to comment on better solutions for some of
the nasty hacks.

### Gemfile

{% highlight ruby %}
group :test do
  gem 'capybara', '~> 1.0.0'

  # The git version worked better for us at the time we installed it.
  gem 'capybara-webkit', :git => "git://github.com/thoughtbot/capybara-webkit"

  # This is needed by capybara's save_and_open_page method.
  gem 'launchy'

  # This *might* be needed in some setups
  gem 'database_cleaner'
end
{% endhighlight %}

### config/initializers/session_store.rb

{% highlight ruby %}
# We deploy our application to several different subdomains, and we need
# to configure the domain for cookies in order to avoid the sessions
# getting mixed.
# But the domain option was messing with capybara browsers' ability to
# remember cookies, so we just exclude the domain config on the test environment.
options = { :key => "_our_app_session_#{Rails.env}" }
options[:domain] = Settings.cookies_host unless Rails.env.test?

Rails.application.config.session_store :cookie_store, options
{% endhighlight %}

### spec/spec_helper.rb

{% highlight ruby %}
RSpec.configure do |config|
  # .. rspec stuff
end

# This is how we load our support files for rspec, this keeps the size of
# the spec_helper.rb file manageable.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
{% endhighlight %}

### spec/support/capybara.rb

{% highlight ruby %}
require "capybara/rails"
require 'capybara/rspec'

# Setup capybara webkit as the driver for javascript-enabled tests.
Capybara.javascript_driver = :webkit

# In our setup, for some reason the browsers capybara was driving were
# not openning the right host:port. Below, we force the correct
# host:port.
Capybara.server_port = 7787

# We have more than one controller inheriting from
# ActionController::Base, and, in our app, ApplicationController redefines
# the default_url_options method, so we need to redefine the method for
# the two classes.
[ApplicationController, ActionController::Base, Listing].each do |klass|
  klass.class_eval do
    def default_url_options(options = {})
      { :host => "127.0.0.1", :port => Capybara.server_port }.merge(options)
    end
  end
end

# Here we do some selective configuration for tests which run with the
# rack backend and tests which run with the webkit backend.
RSpec.configure do |config|
  # In order for the database to have the same data both for the
  # capybara process and the web application process, we need either to
  # disable transactional fixtures (which produces very slow runs),
  # or use the hack you can find below in this file.
  config.use_transactional_fixtures = true

  # Uncomment in case your db gets dirty somehow.
  # DatabaseCleaner.clean_with(:truncation)

  config.before :each do
    if Capybara.current_driver != :rack_test
      # With selenium/webkit the host is set automatically if it was nil.
      Capybara.app_host = nil
    # config.use_transactional_fixtures = false
    # $use_truncation = true
    else
      # We found Capybara.app_host needs to be nil when using rack backend,
      # but point to 127.0.0.1 when using selenium or webkit.
      Capybara.app_host = "http://127.0.0.1"
    # config.use_transactional_fixtures = true
    end
  end

# config.after :each do
#   DatabaseCleaner.clean_with(:truncation) if $use_truncation
# end
end

# Big Fat Hack (TM) so the ActiveRecord connections are shared across threads.
# This is a variation of a hack you can find all over the web to make
# capybara usable without having to switch to non transactional
# fixtures.
# http://groups.google.com/group/ruby-capybara/browse_thread/thread/248e89ae2acbf603/e5da9e9bfac733e0
Thread.main[:activerecord_connection] = ActiveRecord::Base.retrieve_connection

def (ActiveRecord::Base).connection
  Thread.main[:activerecord_connection]
end

# Last but not least, when using capybara-webkit sometimes the response
# is not available when capybara tries to retrieve the contents of the
# page. Of all the possible solutions, this was the simplest for us:
# introducing a fixed delay each time something is clicked in the browser.
# https://github.com/thoughtbot/capybara-webkit/issues/111
class Capybara::Driver::Webkit::Browser
  alias original_command command

  def command(name, *args)
    result = original_command(name, *args)
    sleep(1) if args.first == "click"
    result
  end
end
{% endhighlight %}

### Final Thoughts

Even though the config above allows our acceptance tests to merrily run,
I'm not completely satisfied with the hoops we needed to jump
in order to get things to work.

I have the feeling having the acceptance tests completely isolated from
the main application (even in a separate repository) could be a good
thing. In this direction it would be worthy to try and write the
acceptance tests using a tool like [phantomjs](http://www.phantomjs.org/).
I'm not talking about getting a phantomjs driver for capybara, but
directly writing the whole acceptance suite with phantomjs in
javascript.
