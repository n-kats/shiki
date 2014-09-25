require 'spec_helper'

describe Shiki::Formula do
  before :each do
  end

  after :each do
  end

  it 'should parse' do
    ar = Shiki::Formula.parse <<EOS
hoge:
  HoGe
EOS
    expect(ar).to eq false
  end

  it 'should has README template' do
  end
end
