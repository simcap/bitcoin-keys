require 'minitest_helper'

class TestPublicKey < MiniTest::Test

  def test_return_bitcoin_address
    pubkey_hex = '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.address, '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'

    pubkey_hex = '045c0de3b9c8ab18dd04e3511243ec2952002dbfadc864b9628910169d9b9b00ec243bcefdd4347074d44bd7356d6a53c495737dd96295e2a9374bf5f02ebfc176'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.address, '1thMirt546nngXqyPEz532S8fLwbozud8'
    assert_equal pubkey.to_s, '1thMirt546nngXqyPEz532S8fLwbozud8'
  end

  def test_pubkey_compressed_bitcoin_address
    pubkey_hex = '045c0de3b9c8ab18dd04e3511243ec2952002dbfadc864b9628910169d9b9b00ec243bcefdd4347074d44bd7356d6a53c495737dd96295e2a9374bf5f02ebfc176'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.compressed_address, '14cxpo3MBCYYWCgF74SWTdcmxipnGUsPw3'
  end

  def test_pubkey_compressed
    pubkey_hex = '045c0de3b9c8ab18dd04e3511243ec2952002dbfadc864b9628910169d9b9b00ec243bcefdd4347074d44bd7356d6a53c495737dd96295e2a9374bf5f02ebfc176'
    pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)
    assert_equal pubkey.compressed, '025c0de3b9c8ab18dd04e3511243ec2952002dbfadc864b9628910169d9b9b00ec'
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
