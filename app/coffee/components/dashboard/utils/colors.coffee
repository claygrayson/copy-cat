module.exports = angular.module "copycat.dashboard.colors", [

]

.service "Colors", [
  'APP_COLORS'
  (APP_COLORS) ->
    byName = (name) ->
      color = APP_COLORS[name]
      if !color and materialColors
        c = name.split('-')
        # red-500, blue-a100, deepPurple-500, etc
        if c.length
          color = (materialColors[c[0]] or {})[c[1]]
      color or '#fff'

    {
      byName : byName
    }
]

.constant 'APP_COLORS',
  'gray-darker': '#263238'
  'gray-dark': '#455A64'
  'gray': '#607D8B'
  'gray-light': '#90A4AE'
  'gray-lighter': '#ECEFF1'
  'primary': '#448AFF'
  'success': '#4CAF50'
  'info': '#03A9F4'
  'warning': '#FFB300'
  'danger': '#F44336'