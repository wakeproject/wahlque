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
            sc * lum2 * cut(vec3.inner(p.zenith(lng, lat, ltime), u2))

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

    lng = (i) -> 2 * Math.PI / 256 * i
    r.averageIn = (time, x) ->
        (lat) ->
            scatter = r.energyIn(time, x)(lng(i) ,lat) for i in [0...512]
            sum = 0
            for t in scatter
                sum += t
            sum / 512

    r
