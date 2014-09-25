require 'spec_helper'

describe Shiki::Formula do
  before :each do
  end

  after :each do
  end

  it 'should parse -- simple case' do
    yml =<<EOS
hoge: Hoge
EOS
    expect{Shiki::Formula.parse yml}.not_to raise_error 
  end

  it 'should parse -- complicated case' do
    yml =<<EOS
hoge:
  - >
    :hige :hoo : :foo 
  - [hige, hoo]
  - hige: T
    hoo: 3
EOS
    ar = Shiki::Formula.parse yml
    expect(ar.first.instance_variable_get(:@variables).length).to eq 3
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
