###
  verlet.coffee

  Verlet method to solve some special ODE
###
define [
   'exports',
   'cs!../geometry/vector'
], (e, vec) ->

    e.solve = (acceleration) ->
        (t, x, v, dt) ->
            xnew = vec.addall(x, vec.expand(v, dt), vec.expand(acceleration(t, x, v), dt * dt / 2))
            vnew = vec.addall(v, vec.expand(acceleration(t, x, v), dt / 2), vec.expand(acceleration(t, xnew, v), dt / 2))
            [
                t + dt,
                xnew,
                vnew
            ]

    e