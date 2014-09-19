require "thor"

class Shiki::Command < Thor
  
  argument :name
  def self.source_root
    File.dirname __FILE__
  end

  def create_templates

  end
  
  def create_readme
    copy_file 'templates/README', "#{name}/README"
  end

  def complete_message
    say __FILE__
  end

end
Shiki::Command.start
