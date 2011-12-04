###
  euler.coffee

  Euler method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (x, derivative, dt) -> v.add(x, v.expand(derivative(x), dt))

    e