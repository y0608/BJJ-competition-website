import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-role"
export default class extends Controller {
  static targets = ["competitorFields", "organizerFields"];

  connect() {
    this.showCompetitorFields();
  }

  roleChanged(event) {
    if (event.target.value === "competitor") {
      this.showCompetitorFields();
    } else {
      this.showOrganizerFields();
    }
  }

  showCompetitorFields() {
    this.competitorFieldsTarget.style.display = "block";
    this.organizerFieldsTarget.style.display = "none";
  }

  showOrganizerFields() {
    this.competitorFieldsTarget.style.display = "none";
    this.organizerFieldsTarget.style.display = "block";
  }
}