import { Controller } from '@hotwired/stimulus'

// Connects to data-controller="publication"
export default class extends Controller {
  static targets = ['dateFields']
  static values = {
    control: String,
  }

  toggleDateFields(event) {
    this.dateFieldsTarget.classList.toggle(
      'hidden',
      event.target.value !== this.controlValue
    )
  }
}
