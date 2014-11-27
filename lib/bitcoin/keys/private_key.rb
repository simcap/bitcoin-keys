module Bitcoin
  module Keys
    class PrivateKey

      def initialize(privkey_hex)
        @privkey_hex = privkey_hex
      end

      def to_hex
        @privkey_hex
      end
      alias_method :to_s, :to_hex

    end
  end
end
