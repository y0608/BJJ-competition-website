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

  disconnect() {
    this.stop();
  }
  
  updateTarget(time, display) {
    var minutes = parseInt(time / 60, 10);
    var seconds = parseInt(time % 60, 10);
    var miliseconds = parseInt((time * 100) % 100, 10);
    // if(miliseconds > 49){
    //   seconds++;
    // }

    console.log("minutes: " + minutes + " seconds: " + seconds + " miliseconds: " + miliseconds);    
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
    var my_interval = setInterval(this.updateTarget, 1000, this.timeValue, this.timeTarget);
    // var my_interval = setInterval(this.updateTimer, 1000, this);
  }
  
  stop() {
    clearInterval(this.my_interval);
  }


 
}
