// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from './application'

import CoordinatesController from './coordinates_controller.js'
application.register('coordinates', CoordinatesController)

import FlashController from './flash_controller.js'
application.register('flash', FlashController)

import HelloController from './hello_controller.js'
application.register('hello', HelloController)

import RichEditorController from './rich_editor_controller.js'
application.register('rich-editor', RichEditorController)

import SearchController from './search_controller.js'
application.register('search', SearchController)

import SortableController from './sortable_controller.js'
application.register('sortable', SortableController)
