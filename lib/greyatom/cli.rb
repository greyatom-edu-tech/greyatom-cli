require 'greyatom/user'
require 'greyatom/netrc-interactor'
require 'greyatom/tests/runner'
require 'greyatom/lesson/submit'
require 'greyatom/lesson/open'
require 'thor'

module Greyatom
  class CLI < Thor
    desc "hello", "This will greet you"
    def hello()
      puts "Hello World!"
    end

    desc "setup", "This will ask for token"
    def setup(retries: 5)
      # Check if token already present
      login, password = Greyatom::NetrcInteractor.new().read
      if login.nil? || password.nil?
        print 'Enter your github token here and press [ENTER]: '
        password = STDIN.gets.chomp
        if password.empty?
          puts "No token provided."
          exit
        end
      end
      # Check if token is valid
      user = Greyatom::User.new()
      user.validate(password)
      user.setDefaultWorkspace
    end
    
    desc "reset", "This will forget you"
    def reset()
      Greyatom::User.new().confirmAndReset
    end
    
    desc "open", "This will fork new work"
    def open()
      # Fork and Clone User's current lesson
      Greyatom::Open.new().openALesson
    end
    
    desc "submit", "This will submit your work"
    def submit()
      Greyatom::Submit.new().run
    end
    
    desc "test", "This will test you"
    def test()
      puts 'Testing...'
      Greyatom::Test.new().run
    end

    desc 'version, -v, --version', 'Display the current version of the Learn gem'
    def version
      puts Greyatom::Cli::VERSION
    end
  end
end