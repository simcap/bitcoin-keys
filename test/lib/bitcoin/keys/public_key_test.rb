require 'minitest_helper'

class TestPublicKey < MiniTest::Test

  def test_return_bitcoin_address
    pubkey_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.address, '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
  end

  def test_pubkey_hash
    pubkey_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.to_hash, '00010966776006953d5567439e5e39f86a0d273beed61967f6' 
  end

end
