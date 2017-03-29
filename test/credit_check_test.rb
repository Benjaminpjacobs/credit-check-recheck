require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require 'minitest/pride'
require './lib/credit_check'

class CreditCheckTest < Minitest::Test
  def test_it_exists
    cc = CreditCheck.new("79927398713")
    assert_instance_of CreditCheck, cc
  end

  def test_it_can_split
    cc = CreditCheck.new("79927398713")
    expected = ["7", "9", "9", "2", "7", "3", "9", "8", "7", "1", "3"]
    assert_equal expected, cc.split
    
  end

  def test_it_can_double_every_other_digit_from_right
    cc = CreditCheck.new("79927398713")
    expected = ['7', '18', '9', '4', '7', '6', '9', '16', '7', '2', '3']
    actual = cc.reverse_and_double(["7", "9", "9", "2", "7", "3", "9", "8", "7", "1", "3"])
    assert_equal expected, actual
  end
  
  def test_it_can_combine_double_digit_numbers
    cc = CreditCheck.new("79927398713")
    expected = ['7', '9', '9', '4', '7', '6', '9', '7', '7', '2', '3']
    actual = cc.combine_double_digits(['7', '18', '9', '4', '7', '6', '9', '16', '7', '2', '3'])
    assert_equal expected, actual
  end

  def test_it_can_sum_digits
    cc = CreditCheck.new("79927398713")
    expected = 70
    actual = cc.sum_digits(['7', '9', '9', '4', '7', '6', '9', '7', '7', '2', '3'])
    assert_equal expected, actual
  end

  def test_it_can_mod_ten
    cc = CreditCheck.new("79927398713")
    expected = true
    actual = cc.passes?(70)
    assert_equal expected, actual
  end

  def test_it_can_verify
    cc = CreditCheck.new("79927398713")
    expected = "The number is valid"
    actual = cc.verify  
    assert_equal expected, actual
  end

  def test_it_can_verify_full_card_numebrs
    cc = CreditCheck.new("5541808923795240")
    expected = "The number is valid"
    actual = cc.verify  
    assert_equal expected, actual
  end

  def test_it_finds_invalid
    cc = CreditCheck.new("5541801923795240")
    expected = "The number is invalid"
    actual = cc.verify  
    assert_equal expected, actual
  end

  def test_it_finds_amex_valid
    cc = CreditCheck.new("342804633855673")
    expected = "The number is valid"
    actual = cc.verify  
    assert_equal expected, actual
  end

  def test_if_finds_amex_invalid
    cc = CreditCheck.new("342801633855673")
    expected = "The number is invalid"
    actual = cc.verify  
    assert_equal expected, actual
  end
end