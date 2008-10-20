module Purl
  module Features::Cairo
    class << self
      include ::Purl::Features::Limit

      def operators
        [
          Op.new(:ctx, 2),
          Op.new(:xtc, 1),
          Op.new(:rgb, 4),
          Op.new(:linewidth, 2),
          Op.new(:stroke, 1),
          Op.new(:fill, 1),
          Op.new(:moveto, 3),
          Op.new(:lineto, 3),
          Op.new(:arc, 6, :arc_cw),
          Op.new(:'arc.cw', 6, :arc_cw),
          Op.new(:'arc.ccw', 6, :arc_ccw),
          Op.new(:circle, 4),
        ]
      end

      def ctx(w, h)
        w = [w, @max_width].min
        h = [h, @max_height].min
        Result.new(cairo_context(w, h))
      end

      def xtc(ctx)
        Result.new(ctx.target)
      end

      def rgb(ctx, r, g, b)
        ctx.set_source_rgb r, g, b
        Result.new(ctx)
      end

      def linewidth(ctx, w)
        ctx.set_line_width w
        Result.new(ctx)
      end

      def stroke(ctx)
        ctx.stroke
        Result.new(ctx)
      end

      def fill(ctx)
        if ctx.has_current_point?
          ctx.fill_preserve
        else
          ctx.paint
        end
        
        Result.new(ctx)
      end

      # path
      def moveto(ctx, x, y)
        ctx.move_to x, y
        Result.new(ctx)
      end

      def lineto(ctx, x, y)
        ctx.line_to x, y
        Result.new(ctx)
      end

      def arc_cw(ctx, x, y, radius, b, e)
        ctx.arc x, y, radius, b, e
        Result.new(ctx)
      end

      def arc_ccw(ctx, x, y, radius, b, e)
        ctx.arc_negative x, y, radius, b, e
        Result.new(ctx)
      end

      def circle(ctx, x, y, radius)
        arc_cw(ctx, x, y, radius, 0, 2 * Math::PI)
      end
    end
  end
end
