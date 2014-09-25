require 'spec_helper'

describe Shiki::Formula do
  before :each do
  end

  after :each do
  end

  it 'should parse' do
    ar = Shiki::Formula.parse <<EOS
hoge: >
  HoGe:hige: :hoo
EOS
    expect(ar).to eq false
  end

  it 'should parse -- array' do
    ar = Shiki::Formula.parse <<EOS
hoge:
  - >
    {:hige} :hoo : :foo 
  - [hige, hoo]
  - hige: T
    hoo: 3
EOS
    expect(ar.first.instance_variable_get(:@variables).length).to eq 3
    expect(ar.first.variables.length).to eq 3
  end

  it 'should raise error : illegal order' do
    yml = <<EOS
hoge:
  - >
    {:a}{:b}{:c}
  - [a,b,x]
EOS
    expect{Shiki::Formula.parse yml}.to raise_error
  end
end
