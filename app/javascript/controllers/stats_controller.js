import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

export default class extends Controller {
  static targets = ["canvas"]
  static values = { points: Array, gmthreshold: Number, challthreshold: Number }

  connect() {
    const gameLabels = ["Game 1", "Game 2", "Game 3", "Game 4", "Game 5", "Game 6", "Game 7", "Game 8", "Game 9", "Game 10"]
    // Rank thresholds for LP
    const rankThresholds = {
      'Diamond IV': 0,
      'Diamond III': 100,
      'Diamond II': 200,
      'Diamond I': 300,
      'Master': 400,
      'Grandmaster': 400 + this.gmthresholdValue,
      'Challenger': 400 + this.challthresholdValue,
    }
    const ctx = this.canvasTarget.getContext('2d')
    const lpChart = new Chart(ctx, {
      type: 'line',
      data: {
        labels: gameLabels,
        datasets: [{
          label: 'LP',
          data: this.pointsValue,
          backgroundColor: 'rgba(255, 99, 132, 0.2)',
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 1
        }]
      },
      options: {
        scales: {
          x: {
            display: false // Hides the X-axis labels
          },
          y: {
            beginAtZero: false,
            ticks: {
              // Include rank names in the ticks
              callback: function(value, index, values) {
                let ranks = Object.keys(rankThresholds).filter(rank => rankThresholds[rank] === value)
                return ranks.length > 0 ? ranks[0] : ""
              }
            }
          }
        },
        plugins: {
          legend: {
            display: false,
            labels: {
              color: 'black', // For better visibility in both light and dark mode
            }
          }
        }
      }
    })
  }
}
