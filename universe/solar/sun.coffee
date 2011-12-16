###
  sun.coffee

  The basic paramters for Sun
###
define [
  'exports'
  'cs!/wahlque/physics/units/au'
  'cs!/wahlque/universe/solar/system'
], (exports, au, s) ->

    exports.initPosition = s.p1 #AU
    exports.initVelocity = s.v1 #AU

    exports.mass = s.m1 #AU
    exports.luminosity = 1 # based on Sun's luminosity

    exports