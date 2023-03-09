import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product-form
export default class extends Controller {
  static targets = ['categorySelect', 'subcategorySelect'];

  connect() {
    console.log("Connecting to data-controller");
    this.updateSubcategories();
  }

  updateSubcategories() {
    const category = this.categorySelectTarget.value;
    const subcategories = this.getSubcategories(category);

    this.subcategorySelectTarget.innerHTML = '';
    subcategories.forEach(subcategory => {
      const option = document.createElement('option');
      option.value = subcategory;
      option.text = subcategory;
      this.subcategorySelectTarget.appendChild(option);
    });

    this.subcategorySelectTarget.disabled = subcategories.length == 0;
  }

  getSubcategories(category) {
    const subcategories = {
      service: ['cleaning', 'repair', 'maintenance'],
      goods: ['clothes', 'furniture', 'electronics', 'books']
    };

    return subcategories[category] || [];
  }
}
