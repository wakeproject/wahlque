###
  bodies2.coffee

  2-body simulation
###
define 'cs!/wahlque/nbody/bodies2', [
   'exports',
   'cs!/wahlque/units/au'
], (b2, au) ->

    # derivative in current phase space
    b2.derivative = (m1, m2) ->
        (phase) ->
            [x1, y1, vx1, vy1, x2, y2, vx2, vy2] = phase

            r12 = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
            r21 = r12

            a12 = au.G * m1 / r12 / r12
            a12x = a12 * (x1 - x2) / r12
            a12y = a12 * (y1 - y2) / r12

            a21 = au.G * m2 / r21 / r21
            a21x = a21 * (x2 - x1) / r21
            a21y = a21 * (y2 - y1) / r21

            [
                vx1,
                vy1,
                a21x,
                a21y,
                vx2,
                vy2,
                a12x,
                a12y
            ]

    # return itself
    b2

