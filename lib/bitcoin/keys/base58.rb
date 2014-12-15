module Bitcoin
  module Keys
    module Base58
      ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz".freeze

      module_function

      def encode58(bin)
        bignum = bin.unpack('H*').first.to_i(16)
        result = ""
        while bignum > 0
          bignum, remainder = bignum.divmod(58)
          result << ALPHABET[remainder]
        end
        result = result.each_char.drop_while {|e| e == ALPHABET[0]}.join

        leading_zeros = bin.bytes.take_while {|c| c == 0}.size
        leading_zeros.times do
          result << ALPHABET[0]
        end
        result.reverse
      end
    end
  end
end

