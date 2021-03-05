const name = document.getElementById('query');
const position = document.getElementById('filter_by_position');
const club = document.getElementById('filter_by_club');
const price = document.getElementById('filter_by_max_price');

const disableFilterFields = () => {
  if (name) {
    name.addEventListener('input', (_event) => {
      if (name.value) {
        position.disable = true;
        club.disable = true;
        price.disable = true;
      } else {
        position.disable = false;
        club.disable = false;
        price.disable = false;
      }
    });
  }
};

export { disableFilterFields };
