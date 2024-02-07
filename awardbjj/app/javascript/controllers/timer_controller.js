import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static values = {
    time: Number, // in seconds
    started: Boolean
  }
  static targets = ["time"]

  connect() {
    // check if already started. This means the page was refreshed and the timer was already running
    // maybe update match.timer_minutes and match.timer_seconds every 10 seconds if the match is not finished
    this.updateTarget(this.timeValue, this.timeTarget);
    if (this.startedValue) {
      this.start();
    }
  }


  updateTarget(time, display) {
    var minutes = parseInt(time / 60, 10);
    var seconds = parseInt(time % 60, 10);

    minutes = minutes < 10 ? "0" + minutes : minutes;
    seconds = seconds < 10 ? "0" + seconds : seconds;

    display.textContent = minutes + ":" + seconds;
  }

  updateTimer(that) {
    that.updateTarget(that.timeValue, that.timeTarget);
    if (--that.timeValue < 0) {
      that.timeValue = 0;
    }
  }

  start() {
    // update match.state to "playing" if it's "waiting" (first time starting this timer for this match)
    // update match.timer_state to "running"
    // from stackoverflow:
    // var t = window.setInterval(function() {
    //   if(!isPaused) {
    //     time++;
    //     output.text("Seconds: " + time);
    //   }
    // }, 1000);
    var my_interval = setInterval(this.updateTimer, 1000, this);
  }

  
  stop() {
    // stop timer    
    // update match.timer_state to "running"
  }

  disconnect() {
    // clearInterval(my_interval);
  }
}
