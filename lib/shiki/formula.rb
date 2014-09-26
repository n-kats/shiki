require 'yaml'

class Shiki::Formula
  VAR_REG = /(\\*):([A-Za-z]+)/
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
      rescue
        fail [vars,order].to_s
      end

      def scan_variables(str)
        str.scan(VAR_REG).select{|bs,|bs.to_s.length.even?}.map(&:last).uniq
      end

      def compatible_order?(vars, order)
        (vars - order).length + order.uniq.length == vars.length
      end
  end

  attr_reader :variables
  def initialize(key, macro, vars, order, option)
    @key = key
    @variables = vars || []
    @macro = macro.chomp
    @order = order || []
    @option = option || {}

    sort_variables!
  end

  def sort_variables!
    non_ordered = @variables - @order
    @variables = @order + non_ordered
  end

  def to_tex_macro
    "\\newcommand{\\#{@key}}[#{@variables.length}]{#{insipid_macro}}"
  end

  def use(*arg)
    if arg.last.is_a? Hash
      add_option = arg.pop
    end
    vars = {}
    add_option ||= {}
    @variables.each do |var|
      if add_option.key? var
        vars[var] = add_option[var]
      elsif add_option.key? var.to_sym
        vars[var] = add_option[var.to_sym]
      elsif @option.key? var
        vars[var] = @option[var]
      elsif @option.key? var.to_sym
        vars[var] = @option[var.to_sym]
      else
        vars[var] = arg.shift
      end
    end
    vars = vars.map{|k,v|v}
    case vars.length
    when 0
      "\\#{@key}"
    when 1
      "\\#{@key}[#{vars.shift}]"
    else
      "\\#{@key}[#{vars.shift}]{#{vars.join('}{')}}"
    end
  end
  protected
    def insipid_macro
      mac = @macro.dup
      vars_regs.each_with_index do |reg, i|
        mac.gsub!(reg, "##{i+1}")
      end
      mac
    end

    def vars_regs
      @variables.map{|var| /(?:^|[^\\])(?:\\\\)*:#{var}(?:[^A-Za-z]|$)/ }
    end
  
end

