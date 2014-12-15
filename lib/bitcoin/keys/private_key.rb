module Bitcoin
  module Keys
    class PrivateKey

      def initialize(privkey_hex)
        @privkey_hex = privkey_hex
      end

      def wif(network = '80')
        @wif ||= begin
          versionned = network + @privkey_hex 
          sha = Hasher.hash256_as_hex([versionned].pack('H*'))
          Base58.encode58([versionned + sha[0,8]].pack('H*'))
        end
      end

      def to_wif
        self.wif
      end

      def to_hex
        @privkey_hex
      end
      alias_method :to_s, :to_hex
    end
  end
end
