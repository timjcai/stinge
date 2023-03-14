import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filterItem"]

  filter(e) {
    const btn = e.currentTarget
    const filterBy = btn.dataset.filter
    this.filterItemTargets.forEach((filterItem) => {
      const filterVal = filterItem.dataset.filterValue
      filterItem.style.display = (filterBy === filterVal) ? '' : 'none'
    })

  }

  filterByCheapest(e) {
    this.filterItemTargets.forEach((filterItem) => {
      const isCheapest = filterItem.dataset.cheapest
      filterItem.style.display = isCheapest ? '' : 'none'
    })
  }
}
