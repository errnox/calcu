require 'pp'

module Calcu
  class Helper
    # @macro do_nothing_todo
    # Sends a calculation method to a number with another number as an
    #   argument.
    #
    # @param method [Symbol] method to be called on `a'
    # @param a [Number] number to call `method' on
    # @param b [Number] number to use as argument for the call of `method'
    #   on `a'
    #
    # @return [Number] result of calling `method' on `a' and `b'
    def self.send_calculation(method, a, b)
      a.send(method, b)
    end

    # Prints the provided hash ("options") to stdout
    #
    # @param [Hash{Symbol=>Object}] options Hash which should be written to
    #   stdout
    # @option options [Symbol] :first_name (`John') the first name of a person
    # @option options [Symbol] :last_name (`Doe') the last name of a person
    # @option options [Symbol] :age (`34') the age of a person
    # @option options [Symbol] :notes (`This is John Doe.') notes on a person
    #
    # @return [nil] nothing
    def self.print_options(options)
      options = {
        :first_name => 'John',
        :last_name => 'Doe',
        :age => 34,
        :notes => 'This is John Doe.',
      }.merge(options)
      pp options.inspect
    end
  end
end
