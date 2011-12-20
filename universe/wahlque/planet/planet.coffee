###
  planet.coffee

  The basic paramters for the planet
###
define [
  'exports'
  'cs!/wahlque/math/geometry/vector3'
  'cs!/wahlque/physics/units/au'
  'cs!/wahlque/universe/wahlque/system'
], (p, vec3, au, s) ->

    p.initPosition = s.p3 #AU
    p.initVelocity = s.v3 #AU

    p.radius = 8388608 # SI , and 8388608 = 2^23
    p.period = 23 * 3600 # SI
    p.g = 10 # SI

    # polar unit vector
    p.polar = [0.342, 0, 0.940]

    # base zenith unit vector for lng = 0, lat = 0
    base = [0, 1, 0] # initial base zenith unit vector, change over localtime
    zenithBase = (localtime) ->
        time = localtime - Math.floor(localtime)
        phi = - 2 * Math.PI * time
        cos = Math.cos(phi)
        sin = Math.sin(phi)
        # by Rodrigues' rotation formula
        vec3.add(vec3.expand(base, cos), vec3.expand(vec3.cross(p.polar, base), sin));

    # the normal unit zenith vector for any point on the planet surface
    p.zenith = (lng, lat, localtime) ->
        zb = zenithBase(localtime)
        temp = vec3.add(vec3.expand(zb, Math.cos(lng)), vec3.expand(vec3.cross(p.polar, zb), Math.sin(lng)))
        axis = vec3.cross(p.polar, temp)
        vec3.add(vec3.expand(temp, Math.cos(lat)), vec3.expand(vec3.cross(axis, temp), Math.sin(lat)))

    p