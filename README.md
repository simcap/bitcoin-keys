# Bitcoin::Keys

Generate and manage Bitcoin keys

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bitcoin-keys', require: 'bitcoin/keys'
```

## Usage

#### Generate keys

```ruby
privkey, pubkey = Bitcoin::Keys.generate    # Default to main network

privkey.to_s    # => '18E14A7B6A307F426A94F8114701E7C8E774E7F9A47E2C2035DB29A206321725'
pubkey.to_s     # => '16UwLL9Risc3QfPqBUvKofHmBQ7wMtjvM'
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