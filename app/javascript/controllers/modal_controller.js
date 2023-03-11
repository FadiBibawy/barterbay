import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="modal"
export default class extends Controller {
  connect() {
    this.element.on("shown.bs.modal", () => {
      this.element.querySelector("#myInput").focus()
    })
  }
}
