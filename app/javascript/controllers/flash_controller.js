import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    this.timeout = setTimeout(() => this.element.remove(), 9000)
  }

  disconnect() {
    clearTimeout(this.timeout)
    this.element.remove()
  }
}
