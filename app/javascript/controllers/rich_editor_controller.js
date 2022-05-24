import { Controller } from '@hotwired/stimulus'
import SimpleMDE from 'simplemde'

// Connects to data-controller="rich-editor"
export default class extends Controller {
  connect() {
    this.editor = new SimpleMDE({
      element: this.element,
      spellChecker: false,
      status: false,
      hideIcons: ['preview', 'side-by-side'],
    })
  }

  disconnect() {
    this.editor.toTextArea()
    this.editor = null
  }
}
