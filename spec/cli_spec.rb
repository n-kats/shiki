require 'spec_helper'

describe Shiki::CLI do
  before :each do
    $stdout, $stderr = StringIO.new, StringIO.new
    @original_dir = Dir.pwd
    Dir.chdir "./temp/cli"
  end

  after :each do
    $stdout, $stderr = STDOUT, STDERR
    Dir.chdir @original_dir
  end

  it 'should run' do
    Shiki::CLI.start %w{generate hoge}
    expect($stdout.string).to match /\/lib\/shiki\/command.rb$/
  end

  it 'should has README template' do
    expect(Dir.glob("#{@original_dir}/**/*").include? "#{@original_dir}/lib/shiki/templates/README").to eq true
  end
end
