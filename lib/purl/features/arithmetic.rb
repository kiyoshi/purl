module Purl
  module Features::Arithmetic
    class << self
      def operators
        [
          Op.new(:add, 2),
          Op.new(:sub, 2),
          Op.new(:mul, 2),
          Op.new(:div, 2),
          Op.new(:mod, 2)
        ]
      end

      def add(op1, op2)
        Result.new(op1 + op2)
      end

      def sub(op1, op2)
        Result.new(op1 - op2)
      end

      def mul(op1, op2)
        Result.new(op1 * op2)
      end

      def div(op1, op2)
        Result.new(op1.quo(op2).to_f)
      end

      def mod(op1, op2)
        Result.new(op1 % op2)
      end
    end
  end
end
