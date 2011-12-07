###
  starB.coffee

  The basic paramters for the star B
###
define [
  'exports'
  'cs!/wahlque/physics/units/au'
], (s, au) ->

    m1 = 1.29
    m2 = 1.1
    a = 1.5

    M = m1 + m2
    x2 = - m1 / M * a
    v  = Math.sqrt(au.G * M / a)
    v2 = - v / M * m1

    s.diameter = 1.392e+9 #SI

    s.mass = 1.1 #AU

    s.luminosity = 1.5 # based on Sun's luminosity

    s.initPosition = [x2, 0] #AU
    s.initVelocity = [0, v2] #AU

    s