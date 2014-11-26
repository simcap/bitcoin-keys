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

    def self.convert_to_bitcoin_address(pubkey_hex)
      pubkeyhash = self.pubkey_hash(pubkey_hex)
      self.base_58_check([pubkeyhash].pack('H*'))
    end

    def self.pubkey_hash(pub_key_hex, version = '00')
      bytes = [pub_key_hex].pack('H*')
      digest = Digest::RMD160.hexdigest(Digest::SHA256.digest(bytes))
      hex = version + digest
      raw = [hex].pack('H*')
      sha = Digest::SHA256.digest(raw)
      sha = Digest::SHA256.digest(sha)
      (raw + sha[0,4]).unpack('H*').first
    end

    def self.base_58_check(raw)
      leading_zeros = raw.bytes.take_while {|c| c == 0}.size
      bignum = (raw.unpack('H*').first).to_i(16)
      result = ""
      while bignum > 0
        bignum, remainder = bignum.divmod(58)
        result << BASE_58_ALPHABET[remainder]
      end
      result = result.each_char.drop_while {|e| e == BASE_58_ALPHABET[0]}.join
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
