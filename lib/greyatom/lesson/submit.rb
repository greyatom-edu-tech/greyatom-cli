require 'greyatom/lesson/git-helper'
require 'octokit'

module Greyatom
  class Submit
    def run
      puts 'submit run'
      Greyatom::Submit::GitHelper.new().commitAndPush
      # Just to give GitHub a second to register the repo changes
      sleep(1)
    end
  end
end
