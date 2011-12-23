###
  wau.coffee

  Wahlque astronomical unit system
###
define [
    'exports'
    'cs!./si'
    'cs!../../universe/wahlque/planet/planet'
], (wau, si, p) ->

    wau.fromAU_T = (t) -> t * si.fromAU_T(1) / p.period

    wau
