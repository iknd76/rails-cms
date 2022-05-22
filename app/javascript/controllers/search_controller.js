import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="search"
export default class extends Controller {
  disconnect() {
    clearTimeout(this.timeout)
  }

  submit() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => this.element.requestSubmit(), 200)
  }
}
