# Credova

Credova API Ruby library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'credova'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install credova

## Usage

### Documentation

The full documentation is located here: http://www.rubydoc.info/gems/credova

### Sandbox Mode

If you want to use the Credova 'sandbox' API, set the `Credova.sandbox` flag to `true`.

```ruby
Credova.sandbox = true
# Any API calls will now use the sandbox API.
```

**NOTE**: Credova currently issues different API keys for production and sandbox environments,
which means your production key **will not** work in the sandbox and vice versa.

## Contributing

1. Fork it ( https://github.com/ammoready/credova/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
