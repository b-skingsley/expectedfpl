// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require algolia/v3/algoliasearch.min

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
// require("algoliasearch").start()
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

// ------------------------------------------ ----------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
const algoliasearch = require('algoliasearch');

// Internal imports, e.g:
import { rangeValue } from '../components/range_value';
import { disableFilterFields } from '../components/disable_filter_fields';
import { runCountdown } from '../components/run_countdown';
import { toggleInfoWindows } from '../components/toggle_info_windows';



document.addEventListener('turbolinks:load', () => {
  // runs deadline countdown clock
  runCountdown();
  // dynamically updates display of the max-price-filter-value on footballers index
  rangeValue();
  // toggles disabled attributes of filter inputs depending on if a search value is present
  disableFilterFields();

  toggleInfoWindows();
  switchfunctionality();
  algoliaFunctionality();
});

const switchfunctionality = () => {
  const switches = document.querySelectorAll(".switch");
  const switch1 = document.getElementById("switch1");
  const switch2 = document.getElementById("switch2");
  const form = document.querySelector(".edit_team")
  let counter = 0;

  // add if statement for if you're unselecting a player switch

  if (switches) {
    switches.forEach((button) => {
      button.addEventListener('click', (event) => {
        const parent = event.currentTarget.parentElement;
        if (counter == 0) {
          parent.classList.toggle("active");
          counter += 1;
          switch1.value = parent.parentElement.dataset.id;
        } else if (counter == 1) {
          parent.classList.toggle("active");
          switch2.value = parent.parentElement.dataset.id;
          form.submit();
        }
      });
    });
  }
}

// const benchHtml = (player) => {
//   '<div class="bench-player"><div class="player-content"><i class="fas fa-exchange-alt" id="switch"></i><div class="player-name"><%= player.web_name %></div></div></div>'
// }

// const starterHtml = (player) => {
//   '<div class="starting-player"><div class="player-content"><i class="fas fa-exchange-alt" id="switch"></i><div class="player-name"><%= player.web_name %></div></div></div>'
// }

// const player1 = document.getElementById(`player${player.fplid}`)

const algoliaFunctionality = () => {
  const client = algoliasearch('GESYNVBKIC', '4f4cbe53efd0df512c25a4ec2a75e42c');
  const index = client.initIndex('Footballer');
  const playerResults = document.getElementById("algolia-result");
  const RefineFixtures = document.getElementById("refine-by-player")
  const playerSearch = document.getElementById("query")

  const refineFixtureByPlayer = (event) => {
    event.preventDefault();
    playerSearch.value = playerResults.value;
    // RefineFixtures.click();
  }

  if (playerSearch) {
    playerSearch.addEventListener('keyup', () => {
      playerResults.innerHTML = "";
      index.search(playerSearch.value, { hitsPerPage: 1, page: 0 })
        .then(function searchDone(content) {
          content.hits.forEach((hit) => {
            playerResults.value = `${hit.full_name}`;
          })
            playerResults.addEventListener("click", refineFixtureByPlayer);
        })
        .catch(function searchFailure(err) {
          console.error(err);
        });
    })
  };
}
