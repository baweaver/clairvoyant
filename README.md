# Clairvoyant

## SUPER ALPHA

This is not meant to be used for anything serious at this point. It will at least give you a skeleton for your
code but not much beyond that at this point. You've been warned.

## What is it? (Theoretical)

Divine what code should be written to make a suite of tests pass.

Test code is extremely close to actual code, and a lot of inferences can be made about the nature of the code that would be generated in order to fulfil the tests.

By parsing RSPEC with a secondary DSL, we can formulate an Abstract Syntax Tree from the tests that can be reasonably mapped to working Ruby code.

## Abstract

```
describe Person do
  let(:person) { Person.new('brandon', 23) }

  describe '#name' do
    expect(person.name).to eq('brandon')
  end

  describe '#age' do
    expect(person.age).to eq(23)
  end
end
```

...would map to the AST:
```ruby
{
  person: {
    name: string,
    age: integer
  }
}
```

...and can be converted to:
```ruby
class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age  = age
  end
end
```

This is merely an abstract and requires a lot of work though.

## Usage

Currently it will only work with very basic RSPEC files. This will be tested against later.

```ruby
builder = Clairvoyant.grok('path/to/rspec/file.rb')

# And there's your class!
puts builder
```

## Contributing

1. Fork it ( http://github.com/baweaver/clairvoyant/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
