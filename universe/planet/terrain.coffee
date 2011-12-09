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

    proportion = scale * 16777216 / Math.PI / 8000
    constant = - scale * 111

    t.seeds = ->
        [8, length,
            _.map([
                3103,  3103,  3103,  3103,  3103,  3103,  3103,  3103,  3103, # north pole
                2103, 12288,  5103,  3103,  4103,  6103,  1103, 13103,  2103, # north 67
                1001,  8722, 10288,  7221,  3001,  8011,  7945,  9221,  1001, # north 45
                3001,  8192, 13288,  4372,  9001,  3011, 12288, 10999,  3001, # north 23
                6001,  6103,  5741,  8191,  1099,  4011,  9288,  7221,  6001, # equator
                8009,  2103,  3741,  2056,  5738,  7009,  6103,  6741,  8009, # south 23
                3009,  3188,  5103,  8247,  3009, 10288,  5103, 10247,  3009, # south 45
                4009,  6288, 10103,  6134,  2438,  6792,  3321,  1024,  4009, # south 67
                2327,  2327,  2327,  2327,  2327,  2327,  2327,  2327,  2327, # south pole
            ], ((elem)-> scale * elem))
        ]

    even = (num) -> Math.floor(num / 2) * 2 == num
    odd = (num) -> Math.floor(num / 2) * 2 != num

    residue = 7
    random = (len) ->
        residue = (22695477 * residue + 1) % 64
        part = Math.round(len / proportion * residue / 64)
        residue = (22695477 * residue + 1) % 64
        Math.round(part + constant * residue / 64)

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

        delete data

        [newcount, newlen, dspl]

    t.gen = (seeds) -> md(seeds)

    t
