import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.showModal()
  }

  showModal() {
    this.element.showModal()
  }

  close() {
    this.element.close()
  }
}
