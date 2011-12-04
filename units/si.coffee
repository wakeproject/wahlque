###
  si.coffee

  SI unit system
###
define [
   'exports'
], (si) ->

    si.G = 6.67348e-11

    si.fromAU_L = (l) -> l * 92955807.273
    si.fromAU_T = (t) -> t * 86400
    si.fromAU_M = (m) -> m * 1.98892e30

    si