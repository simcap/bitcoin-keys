require 'minitest_helper'

class TestPrivateKey < MiniTest::Test

  def test_wif_format
    privkey_hex = '1E99423A4ED27608A15A2616A2B0E9E52CED330AC530EDCC32C8FFC6A526AEDD'
    privkey = Bitcoin::Keys::PrivateKey.new(privkey_hex)
    assert_equal privkey.to_wif, '5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn'
    assert_equal privkey.wif, '5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn'

    privkey_hex = '0C28FCA386C7A227600B2FE50B7CAE11EC86D3BF1FBE471BE89827E19D72AA1D'
    privkey = Bitcoin::Keys::PrivateKey.new(privkey_hex)
    assert_equal privkey.to_wif, '5HueCGU8rMjxEXxiPuD5BDku4MkFqeZyd4dZ1jvhTVqvbTLvyTJ'
    assert_equal privkey.wif, '5HueCGU8rMjxEXxiPuD5BDku4MkFqeZyd4dZ1jvhTVqvbTLvyTJ' 
  end
end
