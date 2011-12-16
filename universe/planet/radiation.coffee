###
  radiation.coffee

  The radiation recieved by the planet
###
define [
    'exports'
    'cs!/wahlque/math/geometry/vector3'
    'cs!/wahlque/physics/units/si'
    'cs!/wahlque/physics/units/wau'
    'cs!/wahlque/universe/starA'
    'cs!/wahlque/universe/starB'
    'cs!/wahlque/universe/planet/planet'
], (r, vec3, si, wau, a, b, p) ->

    l1 = a.luminosity
    l2 = b.luminosity
    sc = si.solarConst
    cut = (val) -> val > 0 ? val : 0
    lng = (i) -> 2 * Math.PI / 256 * i
    lat = (j) -> Math.PI / 256 * (128 - j)

    da = Math.PI / 256
    dC = (lat) ->
        Math.PI * p.radius * 2 * p.radius / 256 / 256
    coeff = (dC(lat(j)) for j in [0...256])
    S = 0
    for val in coeff
        S += val
    ratio = (val/S for val in coeff)

    r.total = (time, x) ->
        [x1, y1, x2, y2, x3, y3] = x
        lum1 = l1 / ((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
        lum2 = l2 / ((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
        lum1 + lum2

    r.a = (time, x) ->
        [x1, y1, x2, y2, x3, y3] = x
        lum1 = l1 / ((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
        u1 = vec3.unify([x1 - x3, y1 - y3, 0])
        ltime = wau.fromAU_T(time)

        (lng, lat) ->
            lum1 * cut(vec3.inner(p.zenith(lng, lat, ltime), u1))

    r.b = (time, x) ->
        [x1, y1, x2, y2, x3, y3] = x
        lum2 = l2 / ((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
        u2 = vec3.unify([x2 - x3, y2 - y3, 0])
        ltime = wau.fromAU_T(time)

        (lng, lat) ->
            lum2 * cut(vec3.inner(p.zenith(lng, lat, ltime), u2))

    r.energyIn = (time, x) ->
        [x1, y1, x2, y2, x3, y3] = x
        lum1 = l1 / ((x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3))
        lum2 = l2 / ((x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3))
        u1 = vec3.unify([x1 - x3, y1 - y3, 0])
        u2 = vec3.unify([x2 - x3, y2 - y3, 0])
        ltime = wau.fromAU_T(time)

        (lng, lat) ->
            e1 = sc * lum1 * cut(vec3.inner(p.zenith(lng, lat, ltime), u1))
            e2 = sc * lum2 * cut(vec3.inner(p.zenith(lng, lat, ltime), u2))
            e1 + e2

    r.averageIn = (time, x) ->
        energy = r.energyIn(time, x)
        matrix = (
            (
                energy(lng(i), lat(j)) * coeff[i] for j in [0...256]
            ) for i in [0...256]
        )

        sum = 0
        for i in [0...256]
            for j in [0...256]
                sum += matrix[i][j]

        vector = []
        for i in [0...256]
            row = matrix[i]
            sum = 0
            for j in [0...256]
                sum += matrix[i][j]
            vector[i] = sum

        vector

    r