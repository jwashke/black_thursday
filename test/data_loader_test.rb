require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/data_loader'


class DataLoaderTest < Minitest::Test

  def test_it_can_load_from_a_csv
    assert_equal 126, DataLoader.from_CSV("./test/test_data/items.csv").count
  end

  # def test_it_can_parse_data_to_hash
  #   assert_equal 0, DataLoader.parse_data_to_hash()
  # end
end
