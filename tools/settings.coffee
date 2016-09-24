CSON = require 'cson'
# Settings
S = CSON.load __dirname + '/../def/settings.cson'

applyToPanel = (e) ->
  # Settings panel
  for d in S.Settings.settings
    applyTextContentBySettingsId(d)

  sv = document.querySelector('.settings-view')

  sv.querySelector('#core-settings-note').innerHTML = "Это основные параметры Atom, которые влияют на его поведение. Данные параметры не связаны с редактированием текста. Индивидуальные расширения могут иметь свои собственные параметры. Найти их можно в разделе расширений. <a class='link packages-open'>Список расширений</a>"
  sv.querySelector('#editor-settings-note').innerHTML = "Эти параметры связаны с редактированием текста. Некоторые из них могут быть переопределены на основе каждого языка. Проверьте параметры языка, щелкнув на его расширение в списке расширений. <a class='link packages-open'>Список расширений</a>"

  sv.querySelector('[title="System Settings"]').closest('.panels-item').querySelector('.text').innerHTML = "Эти параметры определяют, как Atom интегрируется с вашей операционной системой."
  # Keybindings
  info = sv.querySelector('.keybinding-panel>div:nth-child(2)')
  unless isAlreadyLocalized(info)
    info.querySelector('span:nth-child(2)').textContent = "Вы можете переопределить эти сочетания клавиш путем копирования "
    info.querySelector('span:nth-child(4)').textContent = " и вставить в"
    info.querySelector('a.link').textContent = " файл сочетания клавиш"
    span = document.createElement('span')
    span.textContent = "Был изменен"
    info.appendChild(span)
    info.setAttribute('data-localized', 'true')

  # Themes panel
  info = sv.querySelector('.themes-panel>div>div:nth-child(2)')
  unless isAlreadyLocalized(info)
    info.querySelector('span').textContent = "Вы также можете"
    info.querySelector('a.link').textContent = " настройки стиля пользователя"
    span = document.createElement('span')
    span.textContent = "Расширения стилей"
    # console.log info
    info.appendChild(span)
    tp1 = sv.querySelector('.themes-picker>div:nth-child(1)')
    tp1.querySelector('.setting-title').textContent = "Тема UI"
    tp1.querySelector('.setting-description').textContent = "Тема будет применяться к программе, в строке состояния, представление в виде дерева и раскрывающиеся меню и так далее"
    tp2 = sv.querySelector('.themes-picker>div:nth-child(2)')
    tp2.querySelector('.setting-title').textContent = "Синтаксис темы"
    tp2.querySelector('.setting-description').textContent = "Тема будет применяться в текстовом редакторе"
    info.setAttribute('data-localized', 'true')

  # Updates panel
  applySpecialHeading(sv, "Available Updates", 2, "Доступные обновления")
  applyTextWithOrg(sv.querySelector('.update-all-button.btn-primary'), "Обновить все")
  applyTextWithOrg(sv.querySelector('.update-all-button:not(.btn-primary)'), "Проверить обновления")
  applyTextWithOrg(sv.querySelector('.alert.icon-hourglass'), "Проверка обновлений...")
  applyTextWithOrg(sv.querySelector('.alert.icon-heart'), "Установленные расширения в актуальном состоянии!")

  # Install panel
  applySectionHeadings()
  inst = document.querySelector('div.section:not(.themes-panel)')
  info = inst.querySelector('.native-key-bindings')
  unless isAlreadyLocalized(info)
    info.querySelector('span:nth-child(2)').textContent = "Расширения опубликованные на "
    tc = info.querySelector('span:nth-child(4)')
    tc.textContent = tc.textContent.replace("and are installed to", "будут установлены в ")
    # info.appendChild(span)
    info.setAttribute('data-localized', 'true')
  applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(1)'), "Расширение")
  applyTextWithOrg(inst.querySelector('.search-container .btn:nth-child(2)'), "Тема")

  # Buttons
  applyButtonToolbar()

applyInstallPanelOnSwitch = () ->
  applySectionHeadings(true)
  applyButtonToolbar()
  inst = document.querySelector('div.section:not(.themes-panel)')
  info = inst.querySelector('.native-key-bindings')
  info.querySelector('span:nth-child(2)').textContent = "Тема расширения"

applySpecialHeading = (area, org, childIdx, text) ->
  sh = getTextMatchElement(area, '.section-heading', org)
  return unless sh && !isAlreadyLocalized(sh)
  sh.childNodes[childIdx].textContent = null
  span = document.createElement('span')
  span.textContent = org
  applyTextWithOrg(span, text)
  sh.appendChild(span)

applySectionHeadings = (force) ->
  sv = document.querySelector('.settings-view')
  for sh in S.Settings.sectionHeadings
    el = getTextMatchElement(sv, '.section-heading', sh.label)
    continue unless el
    if !isAlreadyLocalized(el) and force
      applyTextWithOrg(el, sh.value)
  for sh in S.Settings.subSectionHeadings
    el = getTextMatchElement(sv, '.sub-section-heading', sh.label)
    continue unless el
    if !isAlreadyLocalized(el) and force
      applyTextWithOrg(el, sh.value)

applyButtonToolbar = () ->
  sv = document.querySelector('.settings-view')
  for btn in sv.querySelectorAll('.meta-controls .install-button')
    applyTextWithOrg(btn, "Установить")
  for btn in sv.querySelectorAll('.meta-controls .settings')
    applyTextWithOrg(btn, "Параметры")
  for btn in sv.querySelectorAll('.meta-controls .uninstall-button')
    applyTextWithOrg(btn, "Удалить")
  for btn in sv.querySelectorAll('.meta-controls .icon-playback-pause span')
    applyTextWithOrg(btn, "Отключить")
  for btn in sv.querySelectorAll('.meta-controls .icon-playback-play span')
    applyTextWithOrg(btn, "Включить")

getTextMatchElement = (area, query, text) ->
  elems = area.querySelectorAll(query)
  result
  for el in elems
    if el.textContent.includes(text)
      result = el
      break
  return result

isAlreadyLocalized = (elem) ->
  localized = elem.getAttribute('data-localized') if elem
  return localized is 'true'

applyTextContentBySettingsId = (data) ->
  el = document.querySelector("[id='#{data.id}']")
  return unless el
  ctrl = el.closest('.control-group')
  applyTextWithOrg(ctrl.querySelector('.setting-title'), data.title)
  applyHtmlWithOrg(ctrl.querySelector('.setting-description'), data.desc)
  if data.selectOptions
    options = el.querySelectorAll('option')
    for opt in options
      before = String(opt.textContent)
      applyTextWithOrg(opt, data.selectOptions[before].value)

applyTextWithOrg = (elem, text) ->
  return unless text
  before = String(elem.textContent)
  return if before is text
  elem.textContent = text
  elem.setAttribute('title', before)
  elem.setAttribute('data-localized', 'true')

applyHtmlWithOrg = (elem, text) ->
  return unless text
  before = String(elem.textContent)
  return if before is text
  elem.innerHTML = text
  elem.setAttribute('title', before)
  elem.setAttribute('data-localized', 'true')


Settings =
  init : () ->
    settingsTab = document.querySelector('.tab-bar [data-type="SettingsView"]')
    settingsEnabled = settingsTab.className.includes 'active' if settingsTab
    return unless settingsTab && settingsEnabled
    try
      # Tab title
      # settingsTab.querySelector('.title').textContent = "Настройки"
      sv = document.querySelector('.settings-view')

      # Font
      if process.platform is 'win32'
        font = atom.config.get('editor.fontFamily')
        if font
          sv.style["fontFamily"] = font
        else
          sv.style["fontFamily"] = "'Segoe UI', Microsoft Yahei, sans-serif"
          sv.style["fontSize"] = "12px"

      # Load all settings panels
      lastMenu = sv.querySelector('.panels-menu .active a')
      panelMenus = sv.querySelectorAll('.settings-view .panels-menu li a')
      for pm in panelMenus
        pm.click()
        pm.addEventListener('click', applyInstallPanelOnSwitch)
      # Restore last active menu
      lastMenu.click() if lastMenu

      # on Init
      applyToPanel()

      # Left-side menu
      menu = sv.querySelector('.settings-view .panels-menu')
      return unless menu
      for d in S.Settings.menu
        el = menu.querySelector("[name='#{d.label}']>a")
        applyTextWithOrg el, d.value

      # Left-side button
      ext = sv.querySelector('.settings-view .icon-link-external')
      applyTextWithOrg ext, "Открыть каталог плагинов"

      # Add Events
      btns = sv.querySelectorAll('div.section:not(.themes-panel) .search-container .btn')
      for btn in btns
        btn.addEventListener('click', applyInstallPanelOnSwitch)

    catch e
      console.error "Сбои при локализации программного обеспечения", e

module.exports = Settings
