###
  wau.coffee

  Wahlque astronomical unit system
###
define [
    'exports'
], (wau) ->

    wau.fromAU_T = (t) -> t * 24 / 23

    wau
