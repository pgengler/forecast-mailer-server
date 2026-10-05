require 'test_helper'

class MailHelperTest < ActionView::TestCase
	include MailHelper

	test "temperature with 'both' units shows Celsius with Fahrenheit in parentheses" do
		assert_equal '17.2°C (63.0°F)', temperature(17.21, 'both')
	end

	test "temperature with legacy 'auto' units shows Celsius with Fahrenheit in parentheses" do
		assert_equal '17.2°C (63.0°F)', temperature(17.21, 'auto')
	end

	test "temperature with 'si' units shows Celsius only" do
		assert_equal '17.2°C', temperature(17.21, 'si')
	end

	test "temperature with 'us' units shows Fahrenheit only" do
		assert_equal '63.0°F', temperature(62.98, 'us')
	end

	test "temperature rounds whole-number Celsius values to one decimal" do
		assert_equal '17.0°C (62.6°F)', temperature(17, 'both')
	end
end
