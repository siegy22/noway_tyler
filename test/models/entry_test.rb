require "test_helper"

class EntryTest < ActiveSupport::TestCase
  test "total_points for top (dia 4)" do
    assert_equal 20, entries(:top_one).total_points
  end

  test "total_points for mid (dia 1)" do
    assert_equal 375, entries(:mid_one).total_points
  end

  test "total_points for adc (master)" do
    assert_equal 520, entries(:adc_one).total_points
  end
end
