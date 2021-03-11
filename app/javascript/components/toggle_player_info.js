const teamViewInfo = () => {
  const footballers = document.querySelectorAll('.footballer');
  const table = document.getElementById('team-table');
  let standardInner = '';
  const expandedInner = '<div class="expanded-row-header"></div><div class="expanded-row-body"></div>';


  footballers.forEach((footballer) => {
    // const fullName = footballer.querySelector('.web-name').dataset.fullname;
    // const news = footballer.querySelector('.chances').dataset.news;
    // const form = footballer.querySelector('.points').dataset.form;
    footballer.addEventListener('click', (event) => {
      // Branch if user clicks on the row that is already expanded
      if (event.currentTarget.classList.contains('row-expanded')) {
        event.currentTarget.classList.remove('row-expanded');
        event.currentTarget.innerHTML = standardInner;
        event.currentTarget.classList.add('row-hover-highlight');
        footballers.forEach((footballer) => {
          footballer.classList.remove('row-contracted');
        });
        const fixtures = document.querySelectorAll('.fixture')
        fixtures.forEach((fixture) => {
          fixture.classList.remove('small-font');
        });
        // Branch if the user clicks on a row not expanded, but another row IS expanded
      } else if (table.querySelector('.row-expanded') && event.currentTarget.classList.contains('row-contracted')) {
          table.querySelector('.row-expanded').innerHTML = standardInner;
          table.querySelector('.row-expanded').classList.add('row-contracted');
          table.querySelector('.row-expanded').classList.add('row-hover-highlight');
          table.querySelector('.row-expanded').classList.remove('row-expanded');
          standardInner = event.currentTarget.innerHTML;
          event.currentTarget.classList.add('row-expanded');
          event.currentTarget.innerHTML = expandedInner;
          event.currentTarget.querySelector('.expanded-row-header').innerHTML = `<h4>${event.currentTarget.dataset.fullname}</h4>`;
          event.currentTarget.querySelector('.expanded-row-body').innerHTML = '<button type="button" id="footballer-details" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">See player</button>'
          const footballerButton = document.getElementById('footballer-details');
          const footballerId = event.currentTarget.dataset.id;
          footballerButton.addEventListener('click', (buttonEvent) => {
            const modalArea = document.querySelector('.modal-body');
            modalArea.innerHTML = "";
            fetch(`/footballers/${footballerId}/modal`)
              .then(response => response.text())
              .then(html => {
                modalArea.insertAdjacentHTML('beforeend', html);
              });
          });
          if (event.currentTarget.news) {
            event.currentTarget.querySelector('.expanded-row-body').innerHTML = `<p class="news">${event.currentTarget.dataset.news}</p>`;
          }
          event.currentTarget.classList.remove('row-hover-highlight');
        // Branch if user clicks on a row and no rows are already expanded
      } else {
          footballers.forEach((footballer) => {
            footballer.classList.add('row-contracted');
          });
          const fixtures = document.querySelectorAll('.fixture')
          fixtures.forEach((fixture) => {
            fixture.classList.add('small-font');
          });
          event.currentTarget.classList.remove('row-contracted');
          standardInner = event.currentTarget.innerHTML;
          event.currentTarget.classList.add('row-expanded');
          event.currentTarget.innerHTML = expandedInner;
          event.currentTarget.querySelector('.expanded-row-header').innerHTML = `<h4>${event.currentTarget.dataset.fullname}</h4`;
          event.currentTarget.querySelector('.expanded-row-body').innerHTML = '<button type="button" id="footballer-details" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalLong">See player</button>'
          const footballerButton = document.getElementById('footballer-details');
          const footballerId = event.currentTarget.dataset.id;
          footballerButton.addEventListener('click', (buttonEvent) => {
            const modalArea = document.querySelector('.modal-body');
            modalArea.innerHTML = "";
            fetch(`/footballers/${footballerId}/modal`)
              .then(response => response.text())
              .then(html => {
                modalArea.insertAdjacentHTML('beforeend', html);
              });
          });
          if (event.currentTarget.news) {
            event.currentTarget.querySelector('.expanded-row-body').innerHTML = `<p class="news">${event.currentTarget.dataset.news}</p>`;
          }
          event.currentTarget.classList.remove('row-hover-highlight');
      }
    });
  });
};

const allFootballersInfo = () => {
  const footballers = document.querySelectorAll('.footballer');
  footballers.forEach((footballer) => {
    const fullName = footballer.dataset.fullname;
    const news = footballer.dataset.news;
    const form = footballer.dataset.form;
    footballer.addEventListener('click', (event) => {
      if (footballer.querySelector('.player-info')) {
        footballer.querySelector('.player-info').classList.toggle('hidden');
        footballer.querySelector('.player-info').classList.add('footballer-info');
        footballer.querySelector('.player-info').classList.remove('player-info');
  
        
        footballer.querySelector('.see-footballer').classList.toggle('hidden');
        if (document.getElementById('transfer-out')) {
          footballer.classList.remove('transfer-selected');
          footballer.classList.add('row-hover-highlight')
        }
      } else {
          if (document.getElementById('transfer-out')) {
            footballer.classList.add('transfer-selected');
            footballer.classList.remove('row-hover-highlight')
          }
          console.log(event.currentTarget);
          const footballerButton = event.currentTarget.querySelector('.see-footballer');
          const footballerInfo = event.currentTarget.querySelector('.footballer-info');
          footballerButton.classList.toggle('hidden');
          footballerInfo.classList.add('player-info');
          footballerInfo.classList.remove('hidden');
          footballerButton.addEventListener('click', (event) => {
            event.stopPropagation(); 
          });

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
