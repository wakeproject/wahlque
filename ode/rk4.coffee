###
  rk4.coffee

  Heun(RK4) method to solve ODE
###
define [
   'exports',
   'cs!/wahlque/geometry/vector'
], (e, v) ->

    e.step = (t, x, derivative, dt) ->
        k1 = v.expand(derivative(t, x), dt)
        k2 = v.expand(derivative(t + dt / 2, v.add(x, v.expand(k1, 0.5))), dt)
        k3 = v.expand(derivative(t + dt / 2, v.add(x, v.expand(k2, 0.5))), dt)
        k4 = v.expand(derivative(t + dt, v.add(x, k3)), dt)
        [t + dt, v.addall(x, v.expand(v.add(k1, v.expand(k2, 2), v.expand(k3, 2), k4), 1.0 / 6)]

    e