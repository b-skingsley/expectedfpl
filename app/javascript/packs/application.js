// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
import { rangeValue } from '../components/range_value';
import { disableFilterFields } from '../components/disable_filter_fields';

document.addEventListener('turbolinks:load', () => {
  // dynamically updates display of the max-price-filter-value on footballers index
  rangeValue();
  // toggles disabled attributes of filter inputs depending on if a search value is present
  disableFilterFields();
});

const switches = document.getElementById("switch")

const benchHtml = (player) => {
  '<div class="bench-player"><div class="player-content"><i class="fas fa-exchange-alt" id="switch"></i><div class="player-name"><%= player.web_name %></div></div></div>'
}

const starterHtml = (player) => {
  '<div class="starting-player"><div class="player-content"><i class="fas fa-exchange-alt" id="switch"></i><div class="player-name"><%= player.web_name %></div></div></div>'
}

// const player1 = document.getElementById(`player${player.fplid}`)

const movePlayer = (player1, player2) => {
  playerTwoHtml = player2.outerHTML
}


