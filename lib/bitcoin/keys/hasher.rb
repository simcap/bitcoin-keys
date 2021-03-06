require 'digest'

module Bitcoin
  module Keys
    module Hasher
      module_function

      def hash256(bin)
        Digest::SHA256.digest(
          Digest::SHA256.digest(bin)
        )
      end

      def hash256_as_hex(bin)
        Digest::SHA256.hexdigest(
          Digest::SHA256.digest(bin)
        )
      end

      def hash160(bin)
        Digest::RMD160.digest(
          Digest::SHA256.digest(bin)
        )
      end

      def hash160_as_hex(bin)
        Digest::RMD160.hexdigest(
          Digest::SHA256.digest(bin)
        )
      end
    end
  end
end

