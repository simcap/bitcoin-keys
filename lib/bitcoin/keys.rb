#require "bitcoin/keys/version"
require 'openssl'
require 'digest'

module Bitcoin
  module Keys
    
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
    end

  end
end

if __FILE__ == $0
  keys = Bitcoin::Keys.generate
  puts keys
end
