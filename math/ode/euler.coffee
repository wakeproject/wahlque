###
  euler.coffee

  Euler method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/math/geometry/vector'
], (e, v) ->

    e.solve = (derivative) ->
       (t, x, dt) -> [t + dt, v.add(x, v.expand(derivative(t, x), dt))]

    e