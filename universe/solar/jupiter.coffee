###
  sun.coffee

  The basic paramters for Jupiter
###
define [
  'exports'
  'cs!../../physics/units/au'
  'cs!./system'
], (exports, au, s) ->

    exports.initPosition = s.p2 #AU
    exports.initVelocity = s.v2 #AU

    exports.mass = s.m2 #AU
    exports.luminosity = 0 # based on Sun's luminosity

    exports