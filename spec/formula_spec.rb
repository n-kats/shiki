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

  it 'should escape semicolon' do
    yml = 'hoge: \\:hoge :fo'
    yml2 = 'hoge: \\\\:hoge :fo'
    expect(Shiki::Formula.parse(yml).first.variables.length).to eq 1
    expect(Shiki::Formula.parse(yml2).first.variables.length).to eq(2), Shiki::Formula.parse(yml2).to_s
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

  it 'can be used as tex macro' do
    yml = <<EOS
hoge:
  - >
    :a:b:c
  - [a,c,b]
  - c: c
EOS
    expect{Shiki::Formula.parse(yml).first.to_tex_macro}.not_to raise_error
    expect(Shiki::Formula.parse(yml).first.use(1,2)).to eq("\\hoge[1]{c}{2}")
  end
end
