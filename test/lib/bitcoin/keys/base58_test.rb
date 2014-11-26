require 'minitest_helper'

class TestBase58 < MiniTest::Test

  def test_encode_binary_to_base58
    bin = ["00010966776006953d5567439e5e39f86a0d273beed61967f6"].pack('H*')
    result = Bitcoin::Keys::Base58.encode58(bin)   
    assert_equal '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM', result
  end

end
