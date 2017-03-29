class CreditCheck

  def initialize(card_number)
    @card_number = card_number
  end

  def verify
    split_number  = split
    doubled       = reverse_and_double(split_number)
    combined      = combine_double_digits(doubled)
    summed        = sum_digits(combined)

    passes?(summed) ? p("The number is valid") : p("The number is invalid")
  end

  def split
    @card_number.split('')
  end

  def reverse_and_double(split)
    double(split.reverse).reverse
  end

  def combine_double_digits(doubled)
    doubled.map do |number|
      combine_if_double_digit(number)
    end
  end

  def sum_digits(combined)
    combined.inject do |sum, number|
      sum.to_i + number.to_i
    end
  end

  def passes?(summed)
    summed % 10 == 0
  end

  private

  def double(reversed)
    reversed.each_with_index.map do |number, index|
      multiply_odds(number, index)
    end
  end

  def multiply_odds(number, index)
    if index.odd?
      multiply(number)
    else
      number
    end
  end

  def combine_if_double_digit(number)
    if number.to_i > 9
      combine_double_digit(number).to_s
    else
      number
    end
  end

  def combine_double_digit(number)
    number.split('').map do 
      |num| num.to_i
    end.inject(&:+)
  end

  def multiply(number)
    (number.to_i * 2).to_s 
  end
end
