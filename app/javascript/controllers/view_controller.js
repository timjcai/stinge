import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["default", "coles", "woolworths", "cheapest"]

  connect() {
    // this.element.textContent = "Hello World!"
    console.log("Hello World!")
  }

  default() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.add("active")
    console.log(this.Target)
  }
  coles() {
    // this.element = 'Active'
    this.colesTarget.classList.add("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.remove("active")
    console.log(this.colesTarget.innerText)
  }
  woolworths() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.add("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.remove("active")
    console.log(this.woolworthsTarget.innerText)
  }
  cheapest() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.add("active")
    this.defaultTarget.classList.remove("active")
    console.log(this.cheapestTarget.innerText)
  }
}
