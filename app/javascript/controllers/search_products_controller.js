import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-products"
export default class extends Controller {
  static targets = ["form", "input", "list"]
  connect() {
    console.log("Connecting to data-controller");
    console.log(this.formTarget);
    console.log(this.inputTarget);
    console.log(this.listTarget);
  }
}
