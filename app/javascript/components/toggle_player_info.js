const teamViewInfo = () => {
  const footballers = document.querySelectorAll('.footballer');
  const table = document.getElementById('team-table');
  footballers.forEach((footballer) => {
    // const fullName = footballer.querySelector('.web-name').dataset.fullname;
    // const news = footballer.querySelector('.chances').dataset.news;
    // const form = footballer.querySelector('.points').dataset.form;
    footballer.addEventListener('click', (event) => {
      if (event.currentTarget.classList.contains('row-expanded')) {
        console.log(event.currentTarget.classList);
        event.currentTarget.classList.remove('row-expanded');
        footballers.forEach((footballer) => {
          footballer.classList.remove('row-contracted');
        });
      } else if (table.querySelector('.row-expanded') && event.currentTarget.classList.contains('row-contracted')) {
          table.querySelector('.row-expanded').classList.add('row-contracted');
          table.querySelector('.row-expanded').classList.remove('row-expanded');
          event.currentTarget.classList.add('row-expanded');
      } else {
          footballers.forEach((footballer) => {
            footballer.classList.add('row-contracted');
          });
          event.currentTarget.classList.remove('row-contracted');
          event.currentTarget.classList.add('row-expanded');
      }
    });
  });
};

// query selector all for those that are expanded, remove expanded class from them
// add the expanded to event.currentTarget

const allFootballersInfo = () => {
  const footballers = document.querySelectorAll('.footballer');
  footballers.forEach((footballer) => {
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

const togglePlayerInfo = () => {
  if (document.getElementById('team-table')) {
    teamViewInfo();
  } else {
    allFootballersInfo();
  }
};

export { togglePlayerInfo };
