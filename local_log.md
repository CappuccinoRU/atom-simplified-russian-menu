# Doubts about the translation

* **main.coffee** - complete 100%
* **menu_darwin.cson** - complete 0%
* **menu_linux.cson** - complete 0%

* **context.cson**
```CoffeeScript
27       "encoding-selector:show": "Выбрать кодировки" - Выбор или Выбрать?
35       "autocomplete:toggle": "Триггер: Autocomplete" - Автозавершения кода?
50       "pane:reopen-closed-item": "Открыть закрытую вкладку" - проверить правильность перевода
54,76    "tree-view:move": "Переместить" - Переместить или переименовать?
92       "tree-view:show-in-file-manager": "Показать в Finder" - какой правильный превод для platform Darwin?
```

* **menu_win32.cson**
```CoffeeScript
21      "Init Script..." - нужен правильный перевод
139     value: "Reflow Selection" - узнать правильный перевод/назначение
196     "Run Package &Specs" - узнать правильный перевод
```

* **settings.cson**
```CoffeeScript
52,55   'Development Packages' - уточнить перевод
60      id: 'core.allowPendingPaneItems' - нет перевода
85      id: 'core.destroyEmptyPanes' - уточнить
90      id: 'core.excludeVcsIgnoredPaths'
100     id: 'core.followSymlinks'
105     id: 'core.ignoredNames'
115     id: 'core.projectHome' - проверить корректность перевода
140     id: 'editor.atomicSoftTabs' - не переведено
162     id: 'editor.confirmCheckoutHeadRevision' - проверить перевод/уточнить правильный
177     id:'editor.invisibles.cr' - нужен перевод
182     id:'editor.invisibles.eol' - нужен перевод
187     id:'editor.invisibles.space' - нужен перевод
192     id:'editor.invisibles.tab' - нужен перевод
197     id: 'editor.lineHeight' - уточнить корректность
202     id: 'editor.nonWordCharacters' - уточнить корректность
212     id: 'editor.scrollPastEnd' - уточнить корректность
237     id: 'editor.softTabs' - нужен перевод
247     id: 'editor.softWrapAtPreferredLineLength' - нужен перевод
252     id: 'editor.softWrapHangingIndent' - нужен перевод
263     id: 'editor.tabType' - нужен перевод
267     id: 'editor.undoGroupingInterval' - нужен корректный перевод
273     id: 'editor.useShadowDOM' - нужен корректный перевод
```

* **settings.coffee**
```CoffeeScript
23      span.textContent = "Был изменен"
31      info.querySelector('a.link').textContent = " настройки стиля пользователя"
33      span.textContent = "Расширения стилей"
# console.log info
38      tp1.querySelector('.setting-description').textContent = "Тема будет применяться к программе, в строке состояния, представление в виде дерева и раскрывающиеся меню и так далее"
# Updates panel
47      applyTextWithOrg(sv.querySelector('.update-all-button:not(.btn-primary)'), "Проверить обновления")
48      applyTextWithOrg(sv.querySelector('.alert.icon-hourglass'), "Проверка обновлений...")
# Buttons
72      info.querySelector('span:nth-child(2)').textContent = "Тема расширения"
```