// When sortBy is 0, will sort by points, when any other number will sort by price
// When dir is 0, will sort desc, when any other number will sort asc
const sort = (sortBy, dir) => {
  let footballers = document.querySelectorAll('.footballer');
  let switching = true;
  let shouldSwitch = false;

  while (switching) {
    switching = false;
    for (let i = 0; i < (footballers.length - 1); i++) {
      // Start by saying there should be no switching:
      shouldSwitch = false;
      /* Get the two elements you want to compare,
      one from current row and one from the next: */
      let x = (sortBy === 0 ? parseFloat(footballers[i].querySelector('.points').dataset.points) : parseFloat(footballers[i].querySelector('.price').dataset.price))
      let y = (sortBy === 0 ? parseFloat(footballers[i + 1].querySelector('.points').dataset.points) : parseFloat(footballers[i + 1].querySelector('.price').dataset.price))
      /* Check if the two rows should switch place,
      based on the direction, asc or desc: */
      if (dir === 0) {
        if (x < y) {
          // If so, mark as a switch and break the loop:
          footballers[i].parentNode.insertBefore(footballers[i + 1], footballers[i]);
          footballers = document.querySelectorAll('.footballer');
          switching = true;
          break;
        }
      } else {
          if (x > y) {
            // If so, mark as a switch and break the loop:
            footballers[i].parentNode.insertBefore(footballers[i + 1], footballers[i]);
            footballers = document.querySelectorAll('.footballer');
            switching = true;
            break;
          }
        }
      }
    }
};

const sortFootballers = () => {
  const pointsDown = document.getElementById('sort-points-down');
  const pointsUp = document.getElementById('sort-points-up');
  const priceDown = document.getElementById('sort-price-down');
  const priceUp = document.getElementById('sort-price-up');

  let footballers = document.querySelectorAll('.footballer');

  document.getElementById('footballer-count').innerHTML = `<em>${footballers.length} footballer/s displayed</em>`
  if (footballers.length < 100) {
    document.querySelectorAll('.sort-icon').forEach((icon) => {
      icon.classList.remove('hidden');
    });
    pointsDown.addEventListener('click', (_event) => {
      if (!pointsDown.classList.contains('active')) {
        document.querySelector('.active').classList.remove('active');
        pointsDown.classList.add('active');
        sort(0, 0);
      }
    });
    pointsUp.addEventListener('click', (_event) => {
      if (!pointsUp.classList.contains('active')) {
        document.querySelector('.active').classList.remove('active');
        pointsUp.classList.add('active');
        sort(0, 1);
      }
    });
    priceDown.addEventListener('click', (_event) => {
      if (!priceDown.classList.contains('active')) {
        document.querySelector('.active').classList.remove('active');
        priceDown.classList.add('active');
        sort(1, 0);
      }
    });
    priceUp.addEventListener('click', (_event) => {
      if (!priceUp.classList.contains('active')) {
        document.querySelector('.active').classList.remove('active');
        priceUp.classList.add('active');
        sort(1, 1);
      }
    });
  }
};

export { sortFootballers };
