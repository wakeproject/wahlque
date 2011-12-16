###
  starB.coffee

  The basic paramters for the star B
###
define [
  'exports'
  'cs!/wahlque/physics/units/au'
  'cs!/wahlque/universe/wahlque/system'
], (exports, au, s) ->

    exports.initPosition = s.p2 #AU
    exports.initVelocity = s.v2 #AU

    exports.diameter = 1.392e+9 #SI
    exports.mass = 1.1 #AU
    exports.luminosity = 1.5 # based on Sun's luminosity

    s