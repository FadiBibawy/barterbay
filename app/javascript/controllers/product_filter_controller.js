import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-filter"
export default class extends Controller {
  static targets = ["products"];
  connect() {
    console.log('Hello from Stimulus!');
  }

  async index() {
    const category = document.querySelector('input[name="category"]:checked').value;
    const response = await fetch(`/products?category=${category}`.json, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
      },
    });
    const products = await response.json();
    this.productsTarget.innerHTML = products.map((product) => {
      return `<div>${product.name} (${product.category})</div>`;
    }).join("");
  }
}
