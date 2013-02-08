###
  fields.coffee
###
define [
  'underscore'
], (_) ->

    (maniford, tao) ->
        reg = {}
        env = {}
        gen = []

        ref: (name) -> reg[name]

        def: (name, dependencies..., F) ->
            reg[name] = (t, position) ->
                env[name] = env[name] or {}
                times = Math.floor(t / tao).toString()
                index = maniford.indexOf(position)
                frame = env[name][times]
                if not frame
                    frame = []
                    for i in [1...maniford.size()]
                        frame.push null
                    env[name][times] = frame
                    gen.push times
                    env[name][gen.shift()] = undefined if gen.length > 2
                cur = frame[index]
                if not cur
                    params = _.map dependencies, (depd)-> reg[depd]
                    cur = frame[index] = F t, position, params...
                return cur

