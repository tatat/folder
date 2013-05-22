require 'rubygems'
require 'folder'

class CustomHash < Hash; end

describe Hash, '#fold!' do

  before do
    @hash = {
      'nyan'    => true,
      'n.yan'   => true,
      'ny.an'   => true,
      'nya.n'   => true,
      'n.y.an'  => true,
      'n.ya.n'  => true,
      'ny.a.n'  => true,
      'n.y.a.n' => true,
      :nyan     => false,
      1         => false,
      1.0       => false,
      []        => false,
      {}        => false,
    }
  end

  it 'should have correct keys and values' do
    @hash.fold!

    expect(@hash).to                include(*%w(nyan nya ny n))
    expect(@hash['n']).to           include(*%w(yan ya y))
    expect(@hash['n']['y']).to      include(*%w(an a))
    expect(@hash['n']['y']['a']).to include('n' => true)
    expect(@hash['n']['ya']).to     include('n' => true)
    expect(@hash['n']['yan']).to    be_true
    expect(@hash['ny']).to          include(*%w(an a))
    expect(@hash['ny']['a']).to     include('n' => true)
    expect(@hash['ny']['an']).to    be_true
    expect(@hash['nya']).to         include('n' => true)
    expect(@hash['nyan']).to        be_true

    expect(@hash[:nyan]).to         be_instance_of(FalseClass)
    expect(@hash[1]).to             be_instance_of(FalseClass)
    expect(@hash[1.0]).to           be_instance_of(FalseClass)
    expect(@hash[[]]).to            be_instance_of(FalseClass)
    expect(@hash[{}]).to            be_instance_of(FalseClass)
  end

  it 'should return self' do
    expect(@hash.fold!).to be(@hash)
  end

  it 'should be fold specified separator' do
    hash = {
      'nyan'  => true,
      'ny/an' => true,
    }.fold!('/')

    expect(hash['nyan']).to be_true
    expect(hash['ny']).to   include('an' => true)
  end

  it 'should override duplicate key' do
    @hash.merge!('nya' => true).fold!

    expect(@hash['nya']).not_to be_instance_of(TrueClass)
    expect(@hash['nya']).to     include('n' => true)
  end
end

describe Hash, '#fold' do
  before :all do
    @hash = {}
  end

  it 'should not return self' do
    expect(@hash.fold).not_to be(@hash)
  end
end

describe CustomHash, '#fold!' do
  before do
    @hash = CustomHash['n.y.a.n' => true]
  end

  it 'should fold with instance of CustomHash' do
    @hash.fold!

    expect(@hash).to                be_instance_of(CustomHash)
    expect(@hash['n']).to           be_instance_of(CustomHash)
    expect(@hash['n']['y']).to      be_instance_of(CustomHash)
    expect(@hash['n']['y']['a']).to be_instance_of(CustomHash)
  end
end