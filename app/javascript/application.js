// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import LocalTime from 'local-time'
import './controllers'

LocalTime.start()
