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
            4009,  2251,  7103,  8243,  4009, # south 45
            9199,  9199,  9199,  9199,  9199, # south pole
        ], ((elem)-> scale * elem))
    ]

    even = (num) -> Math.floor(num / 2) * 2 == num
    odd = (num) -> Math.floor(num / 2) * 2 != num

    residual = 7
    random = (len) ->
        residual = (residual * 31 + 37) % 64
        part = Math.round(len / proportion * residual / 64)
        residual = (residual * 31 + 37) % 64
        Math.round(part + residual * constant / 64)

    md = (data) ->
        [count, len, heights] = data

        newcount = count * 2
        newlen = Math.round(len / 2)

        nums = newcount + 1
        seq = ((2 * i) for i in [0..count]) + ((2 * i + 1) for i in [0...count])

        dspl = []
        for row in seq
            for col in seq
                pos = row * nums + col
                if row == 0 # north pole
                    dspl[pos] = heights[0]
                else if row == newcount # south pole
                    dspl[pos] = heights[count * count + count]
                else if col == newcount # on zero longitude circle
                    dspl[pos] = dspl[row * nums + col]
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

        [newcount, newlen, displacement]

    t.gen = (seeds) -> md(seeds)

    t
