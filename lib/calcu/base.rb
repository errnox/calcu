require_relative 'helper'
require_relative 'rack_app'


# Simple calculator
#
# Note: This "calculator" is neither useful nor an example of great
# Ruby code. It simply serves as a test bed for Yard documentation
# writing.
#
# @!macro [new] do_nothing_todo
#   @todo Do nothing. For now.
#
#     _Method_ _name_: `$0'
#
#     _Parameters_: `${1--1}'
module Calcu
  # This is the base for all generic calculations
  # (addition/subtraction/multiplication/division/...).
  module Base
    puts <<-STRINGSTRINGSTRING
Options:
1 - Start web server
2 - Continue
3 - Kill this process

STRINGSTRINGSTRING

    case gets.chomp
    when /1/
      WebServer.new do
        `date`
      end.start
    when /3/
      Process.kill 'TERM', Process.pid
    else
      # Continue.
    end


    # @macro do_nothing_todo
    # @!method foo(string)
    #   @todo Remove.
    #   Prints a string to stdout
    #   @param string [String] string to be preinted to stdout
    #   @return [nil] nothing.
    puts "Calculating... (Process ID: #{Process.pid})"

    # @!visibility public
    # Multiplies two numbers.
    #
    # @param a [Number] first multiplicator
    # @param b [Number] second multiplicator
    #
    # @example
    #
    #   Calcu.mul(3, 4)
    #   # => 12
    #
    # @return [Number] product of both muliplicators
    #
    # @note This method documentation should include an example.
    def self.mul(a, b)
      Calcu::Helper.send_calculation(:*, a, b)
    end

    # @macro do_nothing_todo
    # @!visibility public
    # @todo Clean up
    # Divides two numbers
    #
    # @param a [Number] number to be divided
    # @param b [Number] number to divide the other number by
    #
    # @return [Number] division of both number
    #
    # See also: {Calcu::Base.mul `Calcu::Base.mul'}
    def self.div(a, b)
      a / b
    end

    # @macro do_nothing_todo
    # @todo Clean up
    # Adds two numbers.
    #
    # @param a [Number] first addend
    # @param b [Number] second addend
    #
    # @return [Number] sum of both addends
    # @note This is a test note; here is a test link:
    #   {http://example.com example.com}.
    #
    #   {render:Calcu::Base#add}
    #
    # @see Calcu::Base#add `Calcu::Base#add'
    def self.sum(a, b)
      a + b
    end

    # (see #sum)
    # @note This is an alias for {Calcu::Base.sum `Calcu::Base.sum'}.
    def add(a, b)
      sum a, b
    end

    # Subtracts number b from number a
    #
    # @param a [Number] number to subtract from
    # @param b [Number] number to be subtracted from the other number
    #
    # @return [Number] sum of both addends
    def self.sub(a, b)
      a - b
    end
  end
end
