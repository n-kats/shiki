require 'yaml'

class Shiki::Formula
  class << self
    def parse(yml)
      ar = []
      YAML.load(yml).each do |key, val|
        macro, order, option = analyse(v)
        ar << new(key, macro, order, option)
      end
      ar
    end

    protected
      def analyse(val)
        case val
        when String, Numeric
          val.to_s =~ /:([A-Za-z]+)/
        when Array
          val.first
        else
          fail "unknown Format"
        end
      end
  end
end

