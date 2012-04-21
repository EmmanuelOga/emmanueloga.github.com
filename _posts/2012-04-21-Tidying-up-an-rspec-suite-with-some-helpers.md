---
layout: post
title: Tidying up an rspec suite with helpers
date: 21 April 2012
---

### Conditionally include Rspec Helpers depending on the kind of described thing.

With rpsec you can define helper methods in modules and include them
only in places where it make sense. As an example I use this for specs
related to ActionMailer functionality in rails:

{% highlight ruby %}
module MailSpecHelpers
  class MailDeliveries < Struct.new(:subject)
    def deliveries
      deliveries = ActionMailer::Base.deliveries
      deliveries = deliveries.select { |m| m.subject =~ /#{subject}/ } if subject
      deliveries
    end

    def count
      deliveries.count
    end
  end

  # Returns action mailer deliveries filtered by subject
  def mail_deliveries(subject = nil)
    MailDeliveries.new(subject)
  end
end

module MailerSpecHelpers
  # returns an email from the currently described mailer class.
  def email_for(name, *args)
    described = self.class.describes || self.class.description
    described.send(name, *args)
  end

  # checks that the body of an emails is not blank
  def can_send_an_email_for(name, *args)
    email_for(name, *args).tap do |email|
      email.body.should_not be_blank
    end
  end
end

# Rspec Config File.

RSpec.configure do |config|
  config.include MailSpecHelpers
  config.include MailerSpecHelpers, :example_group => {
    :describes => lambda {|described| described < ActionMailer::Base }
  }
end
{% endhighlight %}

With these helpers in place I can do things like:

{% highlight ruby %}
describe UserMailer do
  let(:user) { User.make! }
  it { can_send_an_email_for(:user_greeting, user) }
end

describe User do
  let(:user) { User.make! }
  let(:greetings) { mail_deliveries("Welcome #{user.first_name}!") }

  it "sends a greeting to the user after activation" do
    expect { user.activate }.to change(greetings, :count).by(1)
  end
end
{% endhighlight %}

Notice MailerSpecHelpers only gets included in specs that describe
ActionMailer::Base derived classes, but MailSpecHelpers is included
everywhere,  because I only want to check if a mailer works in its own
describe block, but I may check for mail deliveries anywhere in the spec
suite.

### Formatting expectations to make it easy to read on the spec

I have an xml generator class that outputs xml without pretty printing
it. Making the code generate pretty output would be too expensive for my
purposes, but I still would like to present the expected output in a
nicely formatted way on the specs. Here's what I did:

{% highlight ruby %}
module Rspec
  module CustomStringHelpers

    class LooksLike < String
      def failure_message
        "#{@me}\n\nis different than:\n\n#{@another}"
      end

      def matches?(another)
        @me, @another = normalize(self), normalize(another)
        @me == @another
      end

      def normalize(str)
        str.split("\n").map(&:strip).join("")
      end
    end

    def look_like(string)
      LooksLike.new(string)
    end

  end
end

# Rspec config file.

RSpec.configure do |config|
  config.include Rspec::CustomStringHelpers
end

# Specs

describe XMLGeneratorThingie do
  let(:schemer) { XMLGeneratorThingie.new }

  it "can add tag attributes to elements" do
    result = schemer.tag(:div, :thing) do |mb|
      mb.tag(:h1, :name, :class => "perico")
    end

    result.should look_like(<<-MARKUP)
      <div itemscope itemtype="http://schema.org/Thing">
        <h1 itemprop="name" class="perico">Spatula</h1>
      </div>
    MARKUP
  end
end
{% endhighlight %}

Blank space and new lines does not matter on xml and I can strip them from
both strings I'm comparing using the look_like helper. Because I control
the generation of the xml, I know that it will work for all different
outputs my code can generate.

### Redefining constants quietly to improve speed of the suite

I use machinist to instantiate actual db records in numerous
places, which can be expensive. This small method allows me to reduce
the number of record instantiations:

{% highlight ruby %}
class Class
  # Allows redefinition of constants without warnings.
  def redefine_const(const_name, new_value)
    remove_const const_name
    const_set const_name, new_value
  end
end
{% endhighlight %}

Usually redefining a constant produces a noisy warning, but with the
redefine_const method I can do that like a ninja:

{% highlight ruby %}
class UserSearch
  LIMIT = 25 # max users to return per search

  def search(*args)
    # implementation...
  end
end

# Specs

describe UserSearch do
  # Reopening the class and overwriting this would normally be noisy.
  # Here we are being explicit and no noise is produced.
  UserSearch.redefine_const :LIMIT, 1

  let (:user1) { User.make! }
  let (:user2) { User.make! }

  def search(*args)
    UserSearch.new(*args)
  end

  context "query-less search" do
    before { user1; user2 }

    it "returns all users with a limit" do
      search.results.length.should == UserSearch::LIMIT
    end
  end
end
{% endhighlight %}

Instead of using redefine_const, I could replace the **LIMIT** constant
with a class-attribute-accessor. But in the example code, LIMIT *should*
be **constant**, something that should not ever change unless I rewrite its
value and redeploy my code. I think is just natural to use a ruby
constant when something is going to be, well..., constant.

## Logging in users automagically

Before putting these helper in place I had to define the current_user or
admin in each controller spec, and sign in in a before-filter as needed.
Now, all I have to do is include a parameter in the describe block to
acknowledge whether there should be an admin or a user logged in that
context.

{% highlight ruby %}
module ControllerMacros

  def sign_in!(kind, *options)
    if kind == :admin
      let(:admin) { Admin.make!(*options) }
      before { sign_in :admin, admin }
    else
      let(:current_user) { User.make!(*options)
      before { sign_in :user, current_user }
    end
  end

end

# RSpec configuration file

RSpec.configure do |config|
  # So useful: if something goes wrong on the view, the spec run will blow up.
  config.render_views

  # Extend only controller specs
  config.extend ControllerMacros, :example_group => {
    :describes => lambda {|described| described < ActionController::Base }
  }

  # Funny flag... but allows me to write symbols instead of hashes.
  config.treat_symbols_as_metadata_keys_with_true_values = true

  # enables: describe(SomeController, :logged_in) { ... }
  config.before(:all, :type => :controller, :logged_in => true) { self.class.sign_in!(:user) }

  # enables: describe(SomeController, :logged_as => :admin / :user / etc..) { ... }
  [:user, :admin].each do |val|
    config.before(:all, :type => :controller, :logged_as => val) { self.class.sign_in!(val) }
  end
end

# Controller specs

describe Admin::Users do
  context "authorized", :logged_as => :admin do
    it "shows a list of users" do
      get :index
      response.should render("index")
    end
  end

  context "not authorized", :logged_as => :user do
    it "redirects the user to the front page" do
      get :index
      response.should redirect_to("/")
    end
  end
end
{% endhighlight %}

### Filtering out specs

If you run a spec manually, you can use **rspec spec/name_spec.rb:25** to
only run the spec defined on the line 25. But if you are using a spec
runner like autotest, or your line numbers change all the time because
you keep adding or removing stuff, that can be annoying. Here is how you
define spec filters:

{% highlight ruby %}

# RSpec configuration file

def ec2_instance?
  # if you retrieve this url from an EC2 instance (and only then) it
  # returns an instance id, so if this does not fail we know we are
  # running inside EC2
  open("http://169.254.169.254/latest/meta-data/instance-id").read rescue nil
end

RSpec.configure do |config|
  # Only run focused specs:
  config.filter_run :focus => true

  # Yep, if there is nothing filtered, run the whole thing.
  config.run_all_when_everything_filtered = true

  # Do not run these specs on the continuous integration server
  config.filter_run_excluding :bypass_on_ec2 => true if ec2_instance?
end

# Specs

describe User do
  it "does something I'm checking RIGHT NOW.", :focus do
    # Stuff I'm working on.
  end

  context "when the external user profile is accessible", :bypass_on_ec2 do
    it "retrieves the file from the server and process it" do
      expect { subject.update_from_server }.to_not raise_error
    end
  end
end
{% endhighlight %}

There are two examples on how to use filtering. First one is simple: I
just add the :focus simple to the block of code I'm currently working
for.

The second one is a little different. Providing you have a good reason
*not* to run some code when you are on an ec2 instance, then you can set
up a block to be skip examples there.
