require 'byebug'
# Counts prefixes from a given array of numbers and
# a given array of existing prefixes
module PrefixCounter
  def self.results(numbers, prefix_list)
    @numbers = numbers
    @prefix_list = prefix_list
    @prefix_count = {}
    count_prefixes
    @prefix_count.sort.to_h
  end

  # Validates number using Contact class and populate prefixes hash
  def self.count_prefixes
    @numbers.each do |number|
      contact = Contact.new number
      contact.extra_characters
      contact.remove_spaces if contact
      next unless contact.length_condition && contact.digits_condition
      match_prefixes(contact.number)
    end
  end

  # finds prefix from number and runs sum_values to populate prefix hash
  def self.match_prefixes(number)
    @prefix_list.each do |prefix|
      sum_values(prefix) if number.start_with?(prefix)
    end
  end

  # populates prefix hash adding prefix if not exist
  def self.sum_values(prefix)
    @prefix_count[prefix] ||= 0
    @prefix_count[prefix] += 1
  end

  # Class for contact number on the array
  class Contact
    attr_accessor :number
    def initialize(number)
      @number = number
    end

    # checks plus sign and 00 in the beginning of number
    def extra_characters
      if @number[0] == '+' && @number[1..2] != '00' && @number[1] != ' '
        @number = remove_plus
      elsif @number[0..1] == '00'
        @number = remove_double_zero
      end
    end

    # removes plus sign from beginning number
    def remove_plus
      @number[1..-1]
    end

    # removes 00 from beginning of number
    def remove_double_zero
      @number[2..-1]
    end

    # removes spaces from numbers
    def remove_spaces
      @number.gsub!(/\s+/, '')
    end

    # checks if number has 3 digits or between 7 and 12 digits
    def length_condition
      @number.length == 3 || (@number.length >= 7 &&
      @number.length <= 12) if @number
    end

    # checks if the number has just digits
    def digits_condition
      @number.scan(/\D/).empty?
    end
  end
end
