require 'thor'
require 'shiki/command' 

class Shiki::CLI < Thor

  desc "generate files", "generate files"
  def generate(*args)
    Shiki::Command.start args
  end

  desc "generate files", "generate files"
  def new(*args)
    Shiki::Command.start args
  end
end
