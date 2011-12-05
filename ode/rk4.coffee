###
  rk4.coffee

  Heun(RK4) method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (x, derivative, dt) ->
        k1 = v.expand(derivative(x), dt)
        k2 = v.expand(derivative(v.add(x, v.expand(k1, 0.5))), dt)
        k3 = v.expand(derivative(v.add(x, v.expand(k2, 0.5))), dt)
        k4 = v.expand(derivative(v.add(x, k3)), dt)
        v.add(x, v.expand(v.add(k1, v.expand(k2, 2), v.expand(k3, 2), k4), 1.0 / 6)

    e