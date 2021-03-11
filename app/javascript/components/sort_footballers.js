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
      let x = (sortBy === 0 ? parseFloat(footballers[i].dataset.points) : parseFloat(footballers[i].dataset.price))
      let y = (sortBy === 0 ? parseFloat(footballers[i + 1].dataset.points) : parseFloat(footballers[i + 1].dataset.price))
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

  if (document.getElementById('transfer-out')) {
    const txOutPosition = document.getElementById('transfer-out').dataset.position
    document.getElementById('footballer-count').innerHTML = `<em>${footballers.length} ${txOutPosition}/s displayed</em>`
  } else {
    document.getElementById('footballer-count').innerHTML = `<em>${footballers.length} footballer/s displayed</em>`
  }

  if (footballers.length < 100) {
    document.querySelectorAll('.sort-icon').forEach((icon) => {
      icon.classList.remove('hidden');
    });
    pointsDown.addEventListener('click', (_event) => {
      if (!pointsDown.classList.contains('activated')) {
        document.querySelector('.activated').classList.remove('activated');
        pointsDown.classList.add('activated');
        sort(0, 0);
      }
    });
    pointsUp.addEventListener('click', (_event) => {
      if (!pointsUp.classList.contains('activated')) {
        document.querySelector('.activated').classList.remove('activated');
        pointsUp.classList.add('activated');
        sort(0, 1);
      }
    });
    priceDown.addEventListener('click', (_event) => {
      if (!priceDown.classList.contains('activated')) {
        document.querySelector('.activated').classList.remove('activated');
        priceDown.classList.add('activated');
        sort(1, 0);
      }
    });
    priceUp.addEventListener('click', (_event) => {
      if (!priceUp.classList.contains('activated')) {
        document.querySelector('.activated').classList.remove('activated');
        priceUp.classList.add('activated');
        sort(1, 1);
      }
    });
  }
};

export { sortFootballers };
