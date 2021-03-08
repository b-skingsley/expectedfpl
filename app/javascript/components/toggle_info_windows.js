const footballers = document.querySelectorAll('.footballer');

const toggleInfoWindows = () => {
  footballers.forEach((footballer) => {
    const name = footballer.querySelector('.web-name');
    const chances = footballer.querySelector('.chances');
    name.addEventListener('mouseover', (_event) => {
      name.insertAdjacentHTML('afterbegin', `<div class="cell-info"><p>${name.dataset.fullname}</p></div>`);
    })
    name.addEventListener('mouseout', (_event) => {
      name.querySelector('.cell-info').remove();
    })
    chances.addEventListener('mouseover', (_event) => {
      if (chances.dataset.news) {
        chances.insertAdjacentHTML('afterbegin', `<div class="cell-info"><p>${chances.dataset.news}</p></div>`);
      }
    })
    chances.addEventListener('mouseout', (_event) => {
      if (chances.dataset.news) {
        chances.querySelector('.cell-info').remove();
      }
    })
  });
};

export { toggleInfoWindows };
