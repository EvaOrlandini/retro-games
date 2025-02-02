import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  checkWord(event) {
    event.preventDefault()
    const form = event.currentTarget
    const formData = new FormData(form)

    fetch(form.action, {
      method: "POST",
      headers: {
        "Accept": "text/plain",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: formData
    })
      .then(response => response.text())
      .then(data => {
        document.getElementById("result").innerHTML = data
      })
  }
}
