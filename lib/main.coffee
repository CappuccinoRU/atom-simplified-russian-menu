class RussianSetting

  constructor: ->
    CSON = require 'cson'
    # Menu
    @M = CSON.load __dirname + '/../def/menu_'+process.platform+'.cson'
    # Right menu
    @C = CSON.load __dirname + '/../def/context.cson'


  activate: (state) ->
    setTimeout(@delay,0)

  delay: () =>
    config = atom.config.get 'simplified-russian-menu'

    if config.useMenu
      # Menu
      @updateMenu(atom.menu.template, @M.Menu)
      atom.menu.update()

    if config.useContext
      # ContextMenu
      @updateContextMenu()

    if config.useSetting
      # Settings (on init and open)
      @updateSettings()
      # After switching over overloaded
      atom.workspace.onDidChangeActivePaneItem (item) =>
        if item and item.uri and item.uri.indexOf('atom://config') isnt -1
          settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
          russianStatus = settingsTab.getAttribute('inRussian')
          if russianStatus isnt 'true'
            settingsTab.setAttribute('inRussian','true')
            @updateSettings(true)

  updateMenu : (menuList, def) ->
    return if not def
    for menu in menuList
      continue if not menu.label
      key = menu.label
      if key.indexOf '…' isnt -1
        key = key.replace('…','...')
      set = def[key]
      continue if not set
      if key is 'VERSION'
        menu.label = set.value+' '+atom.appVersion if set?
      else
        menu.label = set.value if set?
      if menu.submenu?
        @updateMenu(menu.submenu, set.submenu)

  updateContextMenu: () ->
    console.log 'carriedout updateContextMenu'
    for itemSet in atom.contextMenu.itemSets
      set = @C.Context[itemSet.selector]
      continue if not set
      for item in itemSet.items
        continue if item.type is "separator"
        label = set[item.command]
        item.label = label if label?

  updateSettings: (onSettingsOpen = false) ->
    setTimeout(@delaySettings, 0, onSettingsOpen)

  delaySettings: (onSettingsOpen) ->
    settings = require './../tools/settings'
    settings.init()

  config:
    useMenu:
      title: 'Русское меню'
      description: 'Если Вы не хотите использовать русское меню (по умолчанию английское), то можете его отключить (может потребоваться перезагрузка Atom)'
      type: 'boolean'
      default: true
    useSetting:
      title: 'Настройки на русском языке'
      description: 'Если Вы не хотите использовать русский язык в настройках программы (по умолчанию английское), то можете его отключить (может потребоваться перезагрузка Atom)'
      type: 'boolean'
      default: true
    useContext:
      title: 'Перевод контекстного меню'
      description: 'Если Вы не хотите использовать русское контекстное меню (по умолчанию английское), то можете его отключить (может потребоваться перезагрузка Atom)'
      type: 'boolean'
      default: true

module.exports = new RussianSetting()
