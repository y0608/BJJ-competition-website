import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="timer"
export default class extends Controller {
  myInterval = null;

  static values = {
    time: Number, // in seconds
    started: Boolean
  }
  static targets = ["time"]

  connect() {
    this.updateTarget();
    if (this.startedValue) {
      this.myInterval = setInterval(() => { this.updateTimer() }, 100);
    }
  }

  disconnect() {
    clearInterval(this.myInterval);
  }

  updateTarget() {
    let minutes = parseInt(this.timeValue / 60, 10);
    let seconds = parseInt(this.timeValue % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    this.timeTarget.textContent = minutes + ":" + seconds;
  }

  updateTimer() {
    this.timeValue -= 0.1;

    if (this.timeValue < 0) {
      this.timeValue = 0;
      this.startedValue = false;
      clearInterval(this.myInterval);
    }
    this.updateTarget();
  }
}
