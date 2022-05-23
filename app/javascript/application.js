// Entry point for the build script in your package.json
import '@hotwired/turbo-rails'
import LocalTime from 'local-time'
import 'trix'
import '@rails/actiontext'
import './controllers'

LocalTime.start()
