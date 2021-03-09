const footballers = document.querySelectorAll('.footballer');

const toggleInfoWindows = () => {
  footballers.forEach((footballer) => {
    // const name = footballer.querySelector('.web-name');
    // const chances = footballer.querySelector('.chances');
    const fullName = footballer.querySelector('.web-name').dataset.fullname;
    const news = footballer.querySelector('.chances').dataset.news;
    const form = footballer.querySelector('.points').dataset.form;
    footballer.addEventListener('click', (_event) => {
      if (footballer.querySelector('.player-info')) {
        footballer.querySelector('.player-info').remove();
      } else {
        footballer.insertAdjacentHTML('beforeend', `<div class="w-100"></div><div class="col-12 player-info text-center"><p>${fullName}    |    Averaged ${form} points per-game, over last 5 games    |    <span class="news">${news}</span></p></div>`);
      }
    })

  });
};

export { toggleInfoWindows };
