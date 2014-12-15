module Bitcoin
  module Keys
    class PrivateKey

      def initialize(privkey_hex, network = :mainnet)
        @privkey_hex = privkey_hex
        @network = case network
                   when :testnet then 'ef'  
                   when :mainnet then '80'  
                   else raise 'Cannot build key for this network' 
                   end
      end

      def wif
        @wif ||= Base58.encode58(binary_wif(@privkey_hex))
      end

      def wif_compressed
        @wif_compressed ||= Base58.encode58(binary_wif(@privkey_hex + '01'))
      end

      def to_hex
        @privkey_hex
      end
      alias_method :to_s, :to_hex

      private

      def binary_wif(hex_key)
        versionned = @network + hex_key
        sha = Hasher.hash256_as_hex([versionned].pack('H*'))
        [versionned + sha[0,8]].pack('H*')
      end
    end
  end
end
