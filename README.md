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

From an hexadecimal representation
```ruby
pubkey = Bitcoin::Keys::PublicKey.new(pubkey_hex)

pubkey.to_s     # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
pubkey.address  # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
pubkey.to_hash  # => '00010966776006953d5567439e5e39f86a0d273beed61967f6'
pubkey.to_hex   # => '0450863AD64A87AE8A2FE83C1AF1A8403CB53F53E486D8511DAD8A04887E5B23522CD470243453A299FA9E77237716103ABC11A1DF38855ED6F2EE187E9C582BA6'
```