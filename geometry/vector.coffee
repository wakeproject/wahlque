###
  vector.coffee

  n-dimention vector
###
define [
   'exports'
], (v) ->

    # null vector
    v.zero = (n) -> 0 for i in [1..n]

    # vector construction
    v.build = (scalars...) -> scalars

    # add operation
    v.add = (a, b) -> (a[i] + b[i]) for i in [0...a.length]

    # expand operation
    v.expand = (a, c) -> (e * c) for e in a

    # inner product
    v.inner = (a, b) ->
        sigma = 0
        sum = (val) -> sigma = sigma + val
        sum(a[i] * b[i]) for i in [0...a.length]
        sigma

    # vector norm
    v.norm = (a) -> Math.sqrt(v.inner(a, a))

    # vetcor unification
    v.unify = (a) ->
        r = v.norm(a)
        if r != 0
           v.expand(a, 1/r)
        else
            this.zero(a.length)

