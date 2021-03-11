// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//= require algolia/v3/algoliasearch.min
//= require chartkick
//= require Chart.bundle

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
import { runCountdown } from '../components/run_countdown';
import { togglePlayerInfo } from '../components/toggle_player_info';
import { sortFootballers } from '../components/sort_footballers';
import { switchFunctionality } from '../components/switch_functionality';
import { typedNews } from '../components/news_typer';

// window.setTimeout(() => console.log('hi'), 500);

document.addEventListener('turbolinks:load', () => {
  // runs deadline countdown clock

  runCountdown();
  setTimeout(runCountdown, 60000);

  togglePlayerInfo();
  if (document.getElementById('footballer-count')) {
    rangeValue();
    sortFootballers();
  }

  if (document.getElementById('typed')) {
    typedNews();
  }

  if ($('[data-toggle="tooltip"]')) {
    $(function () {
      $('[data-toggle="tooltip"]').tooltip()
    })
  }

  switchFunctionality();
  algoliaFunctionality();
});


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
