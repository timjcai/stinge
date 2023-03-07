import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'


export default class extends Controller {
  initialize(){
    this.priceData = JSON.parse(this.element.dataset.prices);
  }

  connect() {
    const data = this.priceData;

    new Chart(
      document.getElementById('price-chart'),
      {
        type: 'bar',
        data: {
          labels: data.map(row => row.year),
          datasets: [
            {
              label: 'Acquisitions by year',
              data: data.map(row => row.count)
            }
          ]
        }
      }
    );
    // this.element.textContent = this.priceData[0].year;
  }
}
