###
  starA.coffee

  The basic paramters for the star A
###
define [
  'exports'
  'cs!./system'
], (exports, s) ->

    exports.initPosition = s.p1 #AU
    exports.initVelocity = s.v1 #AU
    exports.mass = s.m1 #AU

    exports.diameter = 1.392e+9 #SI
    exports.luminosity = s.lum1 # based on Sun's luminosity

    exports