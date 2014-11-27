module Bitcoin
  module Keys
    class PrivateKey

      def initialize(privkey_hex)
        @privkey_hex = privkey_hex
      end

      def to_s
        @privkey_hex
      end

    end
  end
end
