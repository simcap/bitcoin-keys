#require "bitcoin/keys/version"
require 'openssl'
require 'digest'

module Bitcoin
  module Keys

    BASE_58_ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".freeze
    
    def self.generate
      # Elliptic curve container
      ec = OpenSSL::PKey::EC.new('secp256k1') 
      # Generate public/private keys in container
      ec.generate_key
      # Get keys as hex
      priv_key_as_hex = ec.private_key.to_s(16)
      pub_key_as_hex = ec.public_key.to_bn.to_s(16)

      [priv_key_as_hex, pub_key_as_hex]
    end

    def self.convert_to_bitcoin_address(hex_public_key)
      pub_key_as_string = [hex_public_key].pack('H*')
      sha = Digest::SHA256.digest(pub_key_as_string)
      rmd = Digest::RMD160.digest(sha)
      rmd_hex = rmd.unpack('H*').first
      extended_rmd_as_hex = '00' + rmd_hex
      extended_rmd = [extended_rmd_as_hex].pack('H*') 
      sha = Digest::SHA256.digest(extended_rmd)
      sha = Digest::SHA256.digest(sha)
      first_four_bytes_as_hex = sha.unpack('H8').first
      result = extended_rmd_as_hex + first_four_bytes_as_hex 
      self.base_58_check([result].pack('H*'))
    end

    def self.base_58_check(raw)
      raw_hex = raw.unpack('H*').first
      versionned_raw_hex = '00' + raw_hex
      versionned_raw = [versionned_raw_hex].pack('H*')
      sha = Digest::SHA256.digest(versionned_raw)
      sha = Digest::SHA256.digest(sha)
      concat = versionned_raw + sha.unpack('a4').first
      leading_zeros = concat.unpack('H*').first.each_char.take_while {|c| c == '0'}.size
      bignum = concat.unpack('H*').first.to_i(16)
      result = ""
      while bignum > 0
        bignum, remainder = bignum.divmod(58)
        result << BASE_58_ALPHABET[remainder]
      end
      leading_zeros.times do
        result << BASE_58_ALPHABET[0]
      end
      result.reverse
    end

  end
end

if __FILE__ == $0
  keys = Bitcoin::Keys.generate
  puts keys
end
