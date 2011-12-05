###
  heun.coffee

  Heun(RK2) method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (t, x, derivative, dt) ->
        k1 = v.expand(derivative(t, x), dt)
        k2 = v.expand(derivative(t + dt, v.add(x, k1)), dt)
        [t + dt, v.add(x, v.expand(v.add(k1, k2), 0.5)]

    e