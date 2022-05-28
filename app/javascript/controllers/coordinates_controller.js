import { Controller } from '@hotwired/stimulus'
import { Loader } from '@googlemaps/js-api-loader'

// Connects to data-controller="coordinates"
export default class extends Controller {
  static values = {
    key: String,
  }

  static targets = ['map', 'lat', 'lng']

  connect() {
    const loader = new Loader({
      apiKey: this.keyValue,
      version: 'weekly',
    })

    loader.load().then(() => {
      const center = {
        lat: +this.latTarget.value,
        lng: +this.lngTarget.value,
      }

      this.map = new google.maps.Map(this.mapTarget, {
        center: center,
        zoom: 10,
      })

      const marker = new google.maps.Marker({
        position: center,
        map: this.map,
        draggable: true,
      })

      google.maps.event.addListener(marker, 'dragend', () => {
        this.latTarget.value = marker.getPosition().lat()
        this.lngTarget.value = marker.getPosition().lng()
      })
    })
  }
}
