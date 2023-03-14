import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["default", "coles", "woolworths", "cheapest", "woolworthsm", "colesm", "cheapestm"]

  connect() {
    // this.element.textContent = "Hello World!"
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.remove("active")
    this.cheapestmTarget.setAttribute("hidden", "")
    this.woolworthsmTarget.setAttribute("hidden", "")
    this.colesmTarget.setAttribute("hidden", "")
    console.log("Hello World!")
  }

  default() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.add("active")
    this.cheapestmTarget.setAttribute("hidden", "")
    this.woolworthsmTarget.setAttribute("hidden", "")
    this.colesmTarget.setAttribute("hidden", "")
    console.log(this.defaultTarget.innerText)
  }
  coles() {
    // this.element = 'Active'
    this.colesTarget.classList.add("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.remove("active")
    this.colesmTarget.removeAttribute("hidden", "")
    this.cheapestmTarget.setAttribute("hidden", "")
    this.woolworthsmTarget.setAttribute("hidden", "")
    console.log(this.colesTarget.innerText)
  }
  woolworths() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.add("active")
    this.cheapestTarget.classList.remove("active")
    this.defaultTarget.classList.remove("active")
    this.colesmTarget.setAttribute("hidden", "")
    this.cheapestmTarget.setAttribute("hidden", "")
    this.woolworthsmTarget.removeAttribute("hidden", "")
    console.log(this.woolworthsTarget.innerText)
  }
  cheapest() {
    // this.element = 'Active'
    this.colesTarget.classList.remove("active")
    this.woolworthsTarget.classList.remove("active")
    this.cheapestTarget.classList.add("active")
    this.defaultTarget.classList.remove("active")
    this.woolworthsmTarget.setAttribute("hidden", "")
    this.colesmTarget.setAttribute("hidden", "")
    this.cheapestmTarget.removeAttribute("hidden", "")
    console.log(this.cheapestTarget.innerText)
  }
}
