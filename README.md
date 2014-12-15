# Bitcoin::Keys

Generate and manage Bitcoin keys. Using Ruby stlib only.

## Installation

Add this line to your Gemfile:

```ruby
gem 'bitcoin-keys', require: 'bitcoin/keys'
```

## Usage

#### Generate keys pair

```ruby
pubkey, privkey = Bitcoin::Keys.generate    # Default to main network

pubkey.to_s     # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
privkey.to_s    # => '18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725'
```

#### Generate public key from private key

```ruby
privkey_hex = '18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725'
pubkey, privkey = Bitcoin::Keys.generate_from_private_key(privkey_hex)   # Default to main network

pubkey.address    # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
privkey.to_hex    # => '18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725'
```

#### Public key

From a non compressed hexadecimal representation
```ruby
pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)

pubkey.to_s                  # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
pubkey.address               # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
pubkey.compressed_address    # => '1PMycacnJaSqwwJqjawXBErnLsZ7RkXUAs'
pubkey.to_hex                # => '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD4702...'
pubkey.compressed            # => '0250863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B2352'
```

#### Private key

From a hexadecimal representation
```ruby
privkey = Bitcoin::Keys::PublicKey.new(privkey_hex)            # => For mainnet

privkey.to_s           # => '1E99423A4ED27608A15A2616A2B0E9E52CED330AC530EDCC32C8FFC6A526AEDD'
privkey.to_hex         # => '1E99423A4ED27608A15A2616A2B0E9E52CED330AC530EDCC32C8FFC6A526AEDD'
privkey.wif            # => '5J3mBbAH58CpQ3Y5RNJpUKPE62SQ5tfcvU2JpbnkeyhfsYB1Jcn'
privkey.wif_compressed # => 'KxFC1jmwwCoACiCAWZ3eXa96mBM6tb3TYzGmf6YwgdGWZgawvrtJ'

privkey = Bitcoin::Keys::PublicKey.new(privkey_hex, :testnet)   # => For testnet
...
```
