###
  heun.coffee

  Heun(RK2) method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (x, derivative, dt) ->
        k1 = v.expand(derivative(x), dt)
        k2 = v.expand(derivative(v.add(x, k1)), dt)
        v.add(x, v.expand(v.add(k1, k2), 0.5)

    e