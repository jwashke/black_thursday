require_relative 'test_helper'
require 'minitest/autorun'
require_relative '../lib/data_loader'


class DataLoaderTest < Minitest::Test
  def setup
    @data_loader = DataLoader.new
  end

  def test_it_can_be_instantiated
    assert @data_loader.instance_of?(DataLoader)
  end
end