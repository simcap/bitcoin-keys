require 'bitcoin/keys/version'
require 'bitcoin/keys/hasher'
require 'bitcoin/keys/base58'
require 'bitcoin/keys/public_key'
require 'bitcoin/keys/private_key'

require 'openssl'

module Bitcoin
  module Keys

    def self.generate
      ec = OpenSSL::PKey::EC.new('secp256k1') 
      ec.generate_key
      privkey_hex = "%032x" * ec.private_key.to_int
      pubkey_hex = "%0130x" * ec.public_key.to_bn.to_int

      [PrivateKey.new(privkey_hex), PublicKey.new(pubkey_hex)]
    end

    def self.generate_from_private_key(privkey_hex)
      ec = OpenSSL::PKey::EC.new('secp256k1') 
      privkey_bn = OpenSSL::BN.new(privkey_hex, 16)
      ec.private_key = privkey_bn 
      pubkey_point = ec.group.generator.mul(privkey_bn)
      pubkey_hex = "%0130x" % pubkey_point.to_bn.to_int
      
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
