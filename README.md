# Folder (he said "it's unfold!!!".)

String keys make directory structur

## Installation

Add this line to your application's Gemfile:

    gem 'folder'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install folder

## Usage

Like this

```ruby
h = {'a.b.c' => 'd'}

p h.fold  #=> {"a"=>{"b"=>{"c"=>"d"}}}
p h       #=> {"a.b.c"=>"d"}
p h.fold! #=> {"a"=>{"b"=>{"c"=>"d"}}}
p h       #=> {"a"=>{"b"=>{"c"=>"d"}}}

h = {'a/b/c' => 'd'}

p h.fold      #=> {"a/b/c"=>"d"}
p h.fold('/') #=> {"a"=>{"b"=>{"c"=>"d"}}}
```

### Example (Ruby on Rails)

Controller

```ruby
class ExampleController < ApplicationController

  def create
    render json: Example.create!(example_params)
  end

  protected

  def example_params
    params.fold.require(:example)
      .permit(:nyan, :mew)
  end

end
```

Request

```sh
curl http://localhost:3000/example.json -d example.nyan=neko -d example.mew=koneko
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
