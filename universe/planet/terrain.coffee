###
  terrain.coffee

  The terrain surface of the planet
###
define [
  'underscore'
  'exports'
], (_, t) ->

    # Midpoint displacement algorithm
    # http://en.wikipedia.org/wiki/Diamond-square_algorithm
    # A variant for sphere

    # Basic settings for the MD algorithm
    maxIter = 25 # The length of the big circle is around PI * 2^24 ~ 2^25
    maxHeight = 16384 # SI and 16384 = 2^14

    scale = 64
    length = Math.round(Math.PI * scale * 16777216)

    proportion = 268435456
    constant = 16

    t.seeds = [4, length,
        _.map([
            7103,  7103,  7103,  7103,  7103, # north pole
            9001,  8011, 12288,  8221,  9001, # north 45
            8009,  7103,  7741,  8191,  8009, # equator
            1009,  2251,  7103,  8243,  1009, # south 45
            9199,  9199,  9199,  9199,  9199, # south pole
        ], ((elem)-> scale * elem))
    ]

    md = (data) ->
        [count, len, heights] = data

        newcount = count * 2
        newlen = Math.round(len / 2)

        displacement = []

        [newcount, newlen, displacement]

    t.gen = (seeds) -> md(seeds)

    t
