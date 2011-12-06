###
  bodies2.coffee

  2-body simulation
###
define [
   'exports'
], (b2) ->

    # acceleration in current phase space
    b2.acceleration = (unit, m1, m2) ->
        (t, x) ->
            [x1, y1, x2, y2] = x

            r12 = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
            r21 = r12

            a12 = unit.G * m1 / r12 / r12
            a12x = a12 * (x1 - x2) / r12
            a12y = a12 * (y1 - y2) / r12

            a21 = unit.G * m2 / r21 / r21
            a21x = a21 * (x2 - x1) / r21
            a21y = a21 * (y2 - y1) / r21

            [
              a21x,
              a21y,
              a12x,
              a12y
            ]


    # derivative in current phase space
    b2.derivative = (unit, m1, m2) ->
        (t, phase) ->
            [x1, y1, vx1, vy1, x2, y2, vx2, vy2] = phase
            x = [x1, y1, x2, y2]
            v = [vx1, vy1, vx2, vy2]

            r12 = Math.sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2))
            r21 = r12

            a12 = unit.G * m1 / r12 / r12
            a12x = a12 * (x1 - x2) / r12
            a12y = a12 * (y1 - y2) / r12

            a21 = unit.G * m2 / r21 / r21
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

    b2