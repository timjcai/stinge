import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

export default class extends Controller {
  initialize(){
    this.priceData = JSON.parse(this.element.dataset.prices);
  }

  connect() {
    const alldata = this.priceData;
    const data1 = alldata[0];
    const data2 = alldata[1];

    new Chart(
      document.getElementById('price-chart'),
      {
        type: 'line',
        data: {
          labels: data1.map(row => row.date),
          datasets: [
            {
              label: 'Daily Prices',
              data: data1.map(row => row.price)
            },
            {
              label: 'Daily Prices',
              data: data2.map(row => row.price)
            }
          ]
        }
      }
    );
    // this.element.textContent = this.priceData[0].year;
  }
}
