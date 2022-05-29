import { Controller } from '@hotwired/stimulus'
import { post } from '@rails/request.js'
import Sortable from 'sortablejs'

// Connects to data-controller="sortable"
export default class extends Controller {
  static targets = ['list']
  static values = {
    url: String,
  }

  connect() {
    this.sortables = []
    this.listTargets.forEach((list) => {
      this.sortables.push(
        new Sortable(list, {
          onEnd: this.onEnd.bind(this),
        })
      )
    })
  }

  disconnect() {
    this.sortables.forEach((sortable) => sortable.destroy())
  }

  async onEnd(event) {
    const sgid = event.item.dataset.sgid
    const position = event.newIndex + 1
    await post(this.urlValue, {
      body: JSON.stringify({ sgid, position }),
    })
  }
}
