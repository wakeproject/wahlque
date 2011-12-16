###
  starA.coffee

  The basic paramters for the star A
###
define [
  'exports'
  'cs!/wahlque/physics/units/au'
], (s, au) ->

    m1 = 1.29
    m2 = 1.1
    a = 1.5

    M = m1 + m2
    x1 = m2 / M * a
    v  = Math.sqrt(au.G * M / a)
    v1 = v / M * m2

    s.diameter = 1.392e+9 #SI

    s.mass = 1.29 #AU

    s.luminosity = 2.7 # based on Sun's luminosity

    s.initPosition = [x1, 0] #AU
    s.initVelocity = [0, v1] #AU

    s