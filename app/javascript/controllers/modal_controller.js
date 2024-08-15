import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    console.log("Modal connected")
    this.showModal()
  }

  showModal() {
    if (this.element.tagName === "DIALOG") {
      this.element.showModal()
    }
  }

  close() {
    this.element.close()
  }
}
