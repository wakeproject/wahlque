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

    proportion = scale * 16777216 / 5120
    constant = scale * 257

    t.seeds = ->
        [8, length,
            _.map([
                7103,  7103,  7103,  7103,  7103,  7103,  7103,  7103,  7103, # north pole
                3103, 12288,  7103,  3103,  5103,  7103,  1103,  9103,  3103, # north 67
                1001,  8011, 10288,  8221,  3001,  8011,  7945,  8221,  1001, # north 45
                4001,  8192, 13288,  5372,  9001,  4011, 12288,  9999,  4001, # north 23
                7001,  7103,  7741,  8191,  1099,  4011,  9288,  8221,  7001, # equator
                8009,  2103,  4741,  2056,  6738,  8009,  7103,  7741,  8009, # south 23
                4009,  4188,  7103,  8247,  4009,  9288,  6103,  9247,  4009, # south 45
                5009,  7288,  9103,  7134,  2438,  7792,  4321,  1024,  5009, # south 67
                6327,  6327,  6327,  6327,  6327,  6327,  6327,  6327,  6327, # south pole
            ], ((elem)-> scale * elem))
        ]

    even = (num) -> Math.floor(num / 2) * 2 == num
    odd = (num) -> Math.floor(num / 2) * 2 != num

    residual = 7
    random = (len) ->
        residual = (residual * 47 + 3) % 64
        part = Math.round(len / proportion * residual / 64)
        residual = (residual * 47 + 3) % 64
        Math.round(part + residual * constant / 64)

    md = (data) ->
        [count, len, heights] = data

        newcount = count * 2
        newlen = Math.round(len / 2)

        nums = newcount + 1
        seq = _.flatten([((2 * i) for i in [0..count]), ((2 * i + 1) for i in [0...count])])

        dspl = []
        for row in seq
            for col in seq
                pos = row * nums + col
                if row == 0 # north pole
                    dspl[pos] = heights[0]
                else if row == newcount # south pole
                    dspl[pos] = heights[count * count + count]
                else if col == newcount # on zero longitude circle
                    dspl[pos] = dspl[row * nums]
                else if even(row) and even(col)
                    dspl[pos] = heights[row / 2 * (count + 1) + col / 2]
                else if even(row) and odd(col)
                    dspl[pos] = Math.round((dspl[pos - 1] + dspl[pos + 1]) / 2) + random(len)
                else if odd(row) and even(col)
                    dspl[pos] = Math.round((dspl[pos - nums] + dspl[pos + nums]) / 2) + random(len)
                else if odd(row) and odd(col)
                    dspl[pos] = Math.round(
                       (
                           dspl[pos - nums - 1] + dspl[pos - nums + 1] +
                           dspl[pos + nums - 1] + dspl[pos + nums + 1]
                       ) / 4
                    ) + random(len)

        [newcount, newlen, dspl]

    t.gen = (seeds) -> md(seeds)

    t
