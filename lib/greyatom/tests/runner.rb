require 'yaml'
require 'greyatom/tests/strategies/python-test'

module Greyatom
  class Test

    def initialize()
      die if !strategy
    end

    def run
      strategy.check_dependencies
      strategy.configure
      strategy.run
    end

    def strategy
      @strategy ||= strategies.map{ |s| s.new() }.detect(&:detect)
    end

    private

    def strategies
      [
        Greyatom::Strategies::PythonUnittest
      ]
    end

    def die
      puts "This directory doesn't appear to have any specs in it."
      exit
    end
  end
end
