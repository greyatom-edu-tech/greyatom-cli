require 'greyatom/tests/strategy'

module Greyatom
  module Strategies
    class PythonUnittest < Greyatom::Strategy

      def detect
        files.any? {|f| f.match(/.*.py$/) }
      end

      def files
        @files ||= Dir.entries('.')
      end

      def run
        system("nosetests")
      end

    end
  end
end
