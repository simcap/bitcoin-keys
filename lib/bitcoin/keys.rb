require 'bitcoin/keys/version'
require 'bitcoin/keys/hasher'
require 'bitcoin/keys/base58'
require 'bitcoin/keys/public_key'
require 'bitcoin/keys/private_key'

require 'openssl'

module Bitcoin
  module Keys

    def self.generate
      # Elliptic curve container
      ec = OpenSSL::PKey::EC.new('secp256k1') 
      # Generate public/private keys in container
      ec.generate_key
      # Get keys as hex
      privkey_hex = ec.private_key.to_s(16)
      pubkey_hex = ec.public_key.to_bn.to_s(16)

      [PrivateKey.new(privkey_hex), PublicKey.new(pubkey_hex)]
    end

    def self.convert_to_bitcoin_address(pubkey_hex)
      PublicKey.new(pubkey_hex).address
    end

  end
end

if __FILE__ == $0
  keys = Bitcoin::Keys.generate
  p keys
end
