#require "bitcoin/keys/version"
require "openssl"

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

  end
end

if __FILE__ == $0
  keys = Bitcoin::Keys.generate
  puts keys
end
