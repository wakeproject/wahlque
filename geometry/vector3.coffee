###
  vector3.coffee

  3-dimention vector
###
define ['exports'], (v3) ->

    # null vector
    v3.ZERO = {
             x: 0,
             y: 0,
             z: 0
    }

    # vector construction
    v3.build = (x, y, z) ->
           x: x,
           y: y,
           z: z

    # add operation
    v3.add = (a, b) ->
        x: a.x + b.x,
        y: a.y + b.y,
        z: a.z + b.z

    # expand operation
    v3.expand = (a, c) ->
        x: a.x * c,
        y: a.y * c,
        z: a.z * c

    # inner product
    v3.inner = (a, b) -> a.x * b.x + a.y * b.y + a.z * b.z

    # cross product
    v3.cross = (a, b) ->
        x: a.y * b.z - a.z * b.y,
        y: a.z * b.x - a.x * b.z,
        z: a.x * b.y - a.y * b.x

    # scalar triple product
    v3.triple = (a, b, c) -> v3.inner(a, v3.cross(b, c))

    # vector norm
    v3.norm = (a) -> Math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)

    # vetcor unification
    v3.unify = (a) ->
        r = Math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z)
        if r != 0 {
            x: a.x / r,
            y: a.y / r,
            z: a.z / r
        }
        else
            this.ZERO

    # random vetcor
    v3.random = (r) ->
        theta = (Math.random() - 0.5) * Math.PI
        phi = Math.random() * Math.PI * 2
        if r != 0 {
            if r is undefined {
                x: Math.cos(phi) * Math.cos(theta),
                y: Math.cos(phi) * Math.sin(theta),
                z: Math.sin(phi)
            }
            else {
                x: r * Math.cos(phi) * Math.cos(theta),
                y: r * Math.cos(phi) * Math.sin(theta),
                z: r * Math.sin(phi)
            }
        }
        else
            v3.ZERO

    v3