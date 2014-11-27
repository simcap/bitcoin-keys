module Bitcoin
  module Keys
    class PublicKey

      def initialize(pubkey_hex)
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

      def address
        @pubkey_address ||= begin
          Base58.encode58([self.to_hash].pack('H*'))
        end
      end

      def to_s
        self.address
      end

    end
  end
end
