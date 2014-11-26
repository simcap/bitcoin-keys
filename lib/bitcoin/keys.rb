require 'bitcoin/keys/version'
require 'bitcoin/keys/hasher'
require 'bitcoin/keys/base58'

require 'openssl'

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

    def self.convert_to_bitcoin_address(pubkey_hex)
      pubkeyhash = self.pubkey_hash(pubkey_hex)
      Base58.encode58([pubkeyhash].pack('H*'))
    end

    def self.pubkey_hash(pub_key_hex, version = '00')
      bytes = [pub_key_hex].pack('H*')
      digest = Hasher.hash160_as_hex(bytes)
      hex = version + digest
      raw = [hex].pack('H*')
      sha = Hasher.hash(raw)
      (raw + sha[0,4]).unpack('H*').first
    end

  end
end

if __FILE__ == $0
  keys = Bitcoin::Keys.generate
  puts keys
end
