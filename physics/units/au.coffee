###
  au.coffee

  Astronomical unit system
###
define [
    'exports'
], (au) ->

    au.G = 0.01720209895 * 0.01720209895

    au.fromSI_L = (l) -> l / 92955807.273
    au.fromSI_T = (t) -> t / 86400
    au.fromSI_M = (m) -> m / 1.98892e30

    au