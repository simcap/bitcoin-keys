module Bitcoin
  module Keys

    class InvalidPublicKeyHex < ArgumentError

      def initialize(reason)
        @reason = reason 
      end

      def message
        "Invalid public key hex. #{@reason}" 
      end
    end

    class PublicKey

      def initialize(pubkey_hex)
        self.class.validate(pubkey_hex)
        @pubkey_hex = pubkey_hex
      end

      def to_hash(version = '00')
        @pubkey_hash ||= begin 
          bytes = [@pubkey_hex].pack('H*')
          digest = Hasher.hash160_as_hex(bytes)
          raw = [version + digest].pack('H*')
          sha = Hasher.hash256(raw)
          (raw + sha[0,4]).unpack('H*').first
        end
      end

      def to_hex
        @pubkey_hex
      end

      def compressed
        x, y = coordinates 
        prefix = y.to_i(16).even? ? '02' : '03'
        prefix + x
      end

      def address
        @pubkey_address ||= begin
          Base58.encode58([self.to_hash].pack('H*'))
        end
      end

      def to_s
        self.address
      end

      def self.validate(pubkey_hex)
        unless String === pubkey_hex
          raise InvalidPublicKeyHex.new('Expecting type String')
        end
        unless (invalids = pubkey_hex.downcase.delete('0123456789abcdef')).empty?
          raise InvalidPublicKeyHex.new("Non hex characters #{invalids}.")
        end
        unless pubkey_hex[0..1] == "04"
          raise InvalidPublicKeyHex.new('Expecting uncompressed key with \'04\' prefix.')
        end
        unless pubkey_hex.bytesize == 130
          raise InvalidPublicKeyHex.new('Wrong key length.')
        end
      end

      private 

      def coordinates
        @coordinates ||= [@pubkey_hex[2..65], @pubkey_hex[66..130]]
      end

    end
  end
end
