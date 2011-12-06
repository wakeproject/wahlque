###
  cartesian.coffee

  cartesian coordinate system
###
define [
   'exports',
   'cs!/wahlque/math/functions/commons'
], (c, f) ->
    id = f.id
    one = f.one
    zero = f.zero

    c.basis = [
      [id, zero, zero],
      [zero, id, zero],
      [zero, zero, id],
    ]

    c.metric = [
      [one, zero, zero],
      [zero, one, zero],
      [zero, zero, one],
    ]

    c
