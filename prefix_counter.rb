require 'byebug'
# Counts prefixes from a given array of numbers and
# a given array of existing prefixes
class PrefixCounter
  attr_accessor :numbers
  def self.results(numbers, prefix_list)
    @prefix_count = {}
    numbers.each do |number|
      number = extra_characters(number)
      number = number.gsub(/\s+/, '') if number
      next unless length_condition(number) && check_just_digits(number)
      match_prefixes(number, prefix_list)
    end
    @prefix_count
  end

  def self.extra_characters(number)
    if number[0] == '+' && number[1..2] != '00' && number[1] != ' '
      remove_plus(number)
    elsif number[0..1] == '00'
      remove_double_zero(number)
    else
      number
    end
  end

  def self.remove_plus(number)
    number[1..-1]
  end

  def self.remove_double_zero(number)
    number[2..-1]
  end

  def self.length_condition(number)
    number.length == 3 || (number.length >= 7 && number.length <= 12) if number
  end

  def self.check_just_digits(number)
    number.scan(/\D/).empty?
  end

  def self.match_prefixes(number, prefix_list)
    prefix_list.each do |prefix|
      sum_values(prefix) if number.start_with?(prefix)
    end
  end

  def self.sum_values(prefix)
    @prefix_count[prefix] ||= 0
    @prefix_count[prefix] += 1
  end
end
