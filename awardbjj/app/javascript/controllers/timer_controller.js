import { Controller } from "@hotwired/stimulus"

let my_interval = null;

// Connects to data-controller="timer"
export default class extends Controller {

  static values = {
    time: Number, // in seconds
    started: Boolean
  }
  static targets = ["time"]

  connect() {
    this.updateTarget(this.timeValue, this.timeTarget);
    if (this.startedValue) {
      my_interval = setInterval(this.updateTimer, 200, this);
    }
  }

  disconnect() {
    clearInterval(my_interval);
  }
  
  updateTarget(time, display) {
    var minutes = parseInt(time / 60, 10);
    var seconds = parseInt(time % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    display.textContent = minutes + ":" + seconds;
  }

  updateTimer(that) {
    console.log("updateTimer")
    that.timeValue -= 0.2;
    if (that.timeValue < 0) {
      that.timeValue = 0;
    }
    that.updateTarget(that.timeValue, that.timeTarget);
  }
}
