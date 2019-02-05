
# Part 1

  require 'prime'
  require 'date'
  require 'set'

  def average(a)
    if a.length <= 2
      return 0
    end
    min, max = a.minmax
    sum = a.inject(0, :+)
    if (sum - min - max) % (a.length - 2) == 0
      return (sum - min - max) / (a.length - 2)
    else
      return (sum - min - max).to_f / (a.length - 2).to_f
    end
  end

  def twin_prime?(a,b)
    if (a - b).abs() != 2
      return false
    end
    return Prime.prime?(a) && Prime.prime?(b);
  end

  def check_product?(array, n)
    if array.length < 3
      return false
    end
    for i in (0...array.length - 2)
      for j in (i + 1...array.length - 1)
        for k in (j + 1...array.length)
          if(array[i] * array[j] * array[k] == n)
            return true;
          end
        end
      end
    end
    return false
  end

# Part 2

  def count_vowels(s)
    s = s.to_s.downcase
    count = 0
    if s.scan(/a/).count != 0
      count += 1
    end
    if s.scan(/e/).count != 0
      count += 1
    end
    if s.scan(/i/).count != 0
      count += 1
    end
    if s.scan(/o/).count != 0
      count += 1
    end
    if s.scan(/u/).count != 0
      count += 1
    end
    return count
  end

  def valid_parentheses?(s)
    stack = []
    s.each_char do |char|
      if char == '(' || char == '[' || char == '{'
        stack.push(char)
      else
        if stack.length == 0
          return false
        end
        if (char == ')' && stack.last == '(') || (char == ']' && stack.last == '[') || (char == '}' && stack.last == '{')
          stack.pop
        else
          return false
        end
      end

    end
    return stack.length == 0 ? true : false
  end
  puts valid_parentheses?("()[]{}")

  def longest_common_prefix(s)
    if s.length == 0
      return
    end
    min, max = s.minmax
    puts "min = #{min}, max = #{max}"
    index = min.size.times{|i| break i if min[i] != max[i]}
    return min[0...index]
  end



# Part 3

  class Student
    def initialize(name, enrollment_date)
      if name.nil?
        raise ArgumentError, 'Error: name is nil!'
      elsif name.to_s.empty?
        raise ArgumentError, 'Error: name is empty!'
      elsif enrollment_date.to_s.empty?
        raise ArgumentError, 'Error: date is empty!'
      elsif /^\d{2}-\d{2}-\d{4}$/.match(enrollment_date).nil?
        raise ArgumentError, 'Error: date format is incorrect! (dd-mm-yyyy)'
      else
        @name = name
        @enrollment_date = enrollment_date
      end
    end

    def got_enrolled_on
      if !valid_date?(@enrollment_date)
        'Invalid Date'
      else
        d = Date.strptime(@enrollment_date, '%m-%d-%Y').strftime('%B %d %Y')
        "#{@name} - #{d}"
      end
    end

    def leap_year?(year)
      if (year % 400 == 0) || (year % 100 != 0 && year % 4 == 0)
        true
      else
        false
      end
    end

    def valid_date?(date)
      array = date.to_s.split('-')
      month = array[0].to_i
      day = array[1].to_i
      year = array[2].to_i
      s1 = Set[1, 3, 5, 7, 8, 10, 12]
      s2 = Set[4, 6, 9, 11]
      if s1.include?(month) && day >= 1 && day <= 31
        return true
      elsif s2.include?(month) && day >= 1 && day <= 30
        return true
      end

      if leap_year?(year) && month == 2 && day >= 1 && day <= 29
        return true
      elsif !leap_year?(year) && month == 2 && day >= 1 && day <= 28
        return true
      end

      false
    end

    def name
      @name
    end

    def name=(value)
      @name = value
    end

    def enrollment_date
      @enrollment_date
    end

    def enrollment_date=(value)
      @enrollment_date = value
    end
  end



