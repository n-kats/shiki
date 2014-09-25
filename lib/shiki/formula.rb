require 'yaml'

class Shiki::Formula
  VAR_REG = /(?:^|[^\\])(?:\\\\)*:([A-Za-z]+)/
  class << self
    def parse(yml)
      YAML.load(yml).map do |key, val|
        new(key, *analyse(val))
      end
    end

    protected
      def analyse(val)
        case val
        when Numeric
          [val, [], nil, nil]
        when String
          vars = scan_variables(val)
          [val, vars, nil, nil]
        when Array
          macro = val.first
          vars = scan_variables(macro)
          if val[1] && val[1].is_a?(Array)
            order = val[1]
            fail "illegal order" unless compatible_order?(vars, order)
            if val[2]
              option = val[2]
            end
          elsif val[1]
            option = val[1]
          end
          order ||= nil
          option ||= nil
          [macro, vars, order, option]
        else
          fail "unknown Format"
        end
      end

      def scan_variables(str)
        str.scan(VAR_REG).map(&:first).uniq
      end

      def compatible_order?(vars, order)
        (vars - order).length + order.uniq.length == vars.length
      end
  end

  def initialize(key, macro, vars, order, option)
    @key = key
    @variables = vars || []
    @macro = macro
    @order = order || []
    @option = option || {}

    sort_variables!
  end

  def sort_variables!
    non_ordered = @variables - @order
    @variables = @order + non_ordered
  end

  def to_tex_macro

  end

  protected
  
end

