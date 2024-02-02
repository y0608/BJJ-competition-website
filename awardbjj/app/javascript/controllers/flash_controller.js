import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  connect() {
    const node = this.element;
    setTimeout(() => {
      node.style.visibility = 'hidden';
    }, 3000);
  }
}
