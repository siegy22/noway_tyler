# Pin npm packages by running ./bin/importmap

pin "application"
pin "egg"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.4.2/dist/chart.js"
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.2
pin "konami" # @1.6.3
pin "photoswipe"
pin "photoswipe-lightbox", to: "https://cdnjs.cloudflare.com/ajax/libs/photoswipe/5.4.2/photoswipe-lightbox.esm.min.js"
