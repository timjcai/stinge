import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js/auto'

export default class extends Controller {
  initialize(){
    this.priceData = JSON.parse(this.element.dataset.prices);
    // this.startDate = new Date();
  }

  connect() {
    const alldata = this.priceData;
    const data1 = alldata["Coles"];
    const data2 = alldata["Woolworths"];

    new Chart(
      document.getElementById('price-chart'),
      {
        type: 'line',
        data: {
          labels: data1.map(row => row.date),
          datasets: [
            {
              label: 'Coles',
              data: data1.map(row => row.price),
            },
            {
              label: 'Woolworths',
              data: data2.map(row => row.price)
            }
          ]
        },
        options: {
          scales: {
            y: {
              min: 1,
              max: 8.5,
            }
          }
        }
      }
    );
    // this.element.textContent = this.priceData[0].year;
  }
}
