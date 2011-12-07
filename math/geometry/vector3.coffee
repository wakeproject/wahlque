###
  vector3.coffee

  3-dimention vector
###
define ['exports'], (v3) ->

    # null vector
    v3.ZERO = [0, 0, 0]

    # add operation
    v3.add = (a, b) -> [
        a[0] + b[0]
        a[1] + b[1]
        a[2] + b[2]
    ]

    # expand operation
    v3.expand = (a, c) -> [
        a[0] * c
        a[1] * c
        a[2] * c
    ]

    # inner product
    v3.inner = (a, b) -> a[0] * b[0] + a[1] * b[1] + a[2] * b[2]

    # cross product
    v3.cross = (a, b) ->
        x: a[1] * b[2] - a[2] * b[1]
        y: a[2] * b[0] - a[0] * b[2]
        z: a[0] * b[1] - a[1] * b[0]

    # scalar triple product
    v3.triple = (a, b, c) -> v3.inner(a, v3.cross(b, c))

    # vector norm
    v3.norm = (a) -> Math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2])

    # vetcor unification
    v3.unify = (a) ->
        r = Math.sqrt(a[0] * a[0] + a[1] * a[1] + a[2] * a[2])
        if r != 0
            [
                a[0]/ r
                a[1]/ r
                a[2]/ r
            ]
        else
            this.ZERO

    # random vetcor
    v3.random = (r) ->
        theta = (Math.random() - 0.5) * Math.PI
        phi = Math.random() * Math.PI * 2
        if r != 0
            if r is undefined
                [
                    Math.cos(phi) * Math.cos(theta)
                    Math.cos(phi) * Math.sin(theta)
                    Math.sin(phi)
                ]
            else
                [
                    r * Math.cos(phi) * Math.cos(theta)
                    r * Math.cos(phi) * Math.sin(theta)
                    r * Math.sin(phi)
                ]
        else
            v3.ZERO

    v3