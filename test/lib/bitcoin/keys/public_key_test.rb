require 'minitest_helper'

class TestPublicKey < MiniTest::Test

  def test_return_bitcoin_address
    pubkey_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.address, '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
  end

  def test_pubkey_compressed
    pubkey_hex = '0479be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798483ada7726a3c4655da4fbfc0e1108a8fd17b448a68554199c47d08ffb10d4b8'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.compressed, '0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798'
  end

  def test_pubkey_hash
    pubkey_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.to_hash, '00010966776006953d5567439e5e39f86a0d273beed61967f6' 
  end

  def test_validate_hex_pubkey
    assert_raises Bitcoin::Keys::InvalidPublicKeyHex do |error|
      Bitcoin::Keys::PublicKey.new(8)
      assert_match /String/, error.message
    end
    assert_raises Bitcoin::Keys::InvalidPublicKeyHex do |error|
      Bitcoin::Keys::PublicKey.new('04gzAASS')
      assert_match /gzss/, error.message
    end
    assert_raises Bitcoin::Keys::InvalidPublicKeyHex do |error|
      Bitcoin::Keys::PublicKey.new('05')
      assert_match /uncompressed.*prefix/, error.message
    end
    assert_raises Bitcoin::Keys::InvalidPublicKeyHex do |error|
      Bitcoin::Keys::PublicKey.new('0434567aa6789f56789e')
      assert_match /length/, error.message
    end
  end

end
