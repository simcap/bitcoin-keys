require 'minitest_helper'

class TestBitcoinKeys < MiniTest::Test

  def test_generate_pair_of_keys
    pubkey, privkey  = Bitcoin::Keys.generate

    assert pubkey.is_a? Bitcoin::Keys::PublicKey
    assert privkey.is_a? Bitcoin::Keys::PrivateKey
  end

  def test_generate_public_key_from_private_key
    privkey_hex = '18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725'
    pubkey, privkey  = Bitcoin::Keys.generate_from_private_key(privkey_hex)

    assert_equal privkey.to_hex, privkey_hex
    assert_equal pubkey.to_hex, '0450863ad64a87ae8a2fe83c1af1a8403cb53f53e486d8511dad8a04887e5b23522cd470243453a299fa9e77237716103abc11a1df38855ed6f2ee187e9c582ba6'
    assert_equal pubkey.address, '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
  end

  def test_convert_public_key_to_bitcoin_address_as_hex
    pubkey = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    address = Bitcoin::Keys.convert_to_bitcoin_address(pubkey)

    assert_equal '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM', address
  end
end
