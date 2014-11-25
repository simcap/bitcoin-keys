require 'minitest_helper'

class TestBitcoinKeys < MiniTest::Unit::TestCase
  def test_convert_public_key_to_bitcoin_address_as_hex
    pub_key = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    address = Bitcoin::Keys.convert_to_bitcoin_address(pub_key)
    assert_equal address, '00010966776006953D5567439E5E39F86A0D273BEED61967F6'.downcase
  end
end
