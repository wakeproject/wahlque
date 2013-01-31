###
  system.coffee

  The basic paramters for wahlque system
###
define [
  'exports'
  'cs!../../physics/units/au'
  'cs!../../math/ode/verlet'
  'cs!../../math/geometry/vector3'
  'cs!../../physics/nbody/bodies3pr'
], (s, au, solver, vec3, b3) ->

    m1 = 1.29
    m2 = 1.1
    a = 1.5
    l = 3.0
    # based on Sun's luminosity
    lum1 = 2.7
    lum2 = 1.5

    M = m1 + m2
    x1 = m2 / M * a
    x2 = - m1 / M * a

    v  = Math.sqrt(au.G * M / a)
    v1 = v / M * m2
    v2 = - v / M * m1
    v3 =  Math.sqrt(au.G * M / l)

    s.m1 = m1
    s.m2 = m2
    s.p1 = [x1, 0]
    s.p2 = [x2, 0]
    s.p3 = [0, l]
    s.v1 = [0, v1]
    s.v2 = [0, v2]
    s.v3 = [v3, 0]

    acceleration = b3.acceleration(au, m1, m2)
    step = solver.solve(acceleration)

    s.time = 0
    s.x = [x1, 0, x2, 0, 0, l]
    s.v = [0, v1, 0, v2, v3, 0]
    s.step = (tao) ->
        [time, x, v] = step(s.time, s.x, s.v, tao)
        [x_1, y_1, x_2, y_2, x_3, y_3] = x
        [vx_1, vy_1, vx_2, vy_2, vx_3, vy_3] = v
        D13 = (x_1 - x_3) * (x_1 - x_3) + (y_1 - y_3) * (y_1 - y_3)
        D12 = (x_1 - x_2) * (x_1 - x_2) + (y_1 - y_2) * (y_1 - y_2)
        D23 = (x_2 - x_3) * (x_2 - x_3) + (y_2 - y_3) * (y_2 - y_3)
        s.time = time
        s.x = x
        s.v = v
        s.lum1 = lum1 / D13
        s.lum2 = lum2 / D23
        s.u1 = vec3.unify([x_1 - x_3, y_1 - y_3, 0])
        s.u2 = vec3.unify([x_2 - x_3, y_2 - y_3, 0])
        s.K = (m1 * (vx_1 * vx_1 + vy_1 * vy_1) + m2 * (vx_2 * vx_2 + vy_2 * vy_2)) / 2
        s.U = - au.G * m1 * m2 / Math.sqrt(D12)
        s.E = s.K + s.U

    s