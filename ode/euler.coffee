###
  euler.coffee

  Euler method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (t, x, derivative, dt) -> [t + dt, v.add(x, v.expand(derivative(t, x), dt))]

    e