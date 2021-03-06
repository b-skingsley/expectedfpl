const teamViewInfo = () => {
  const footballers = document.querySelectorAll('.footballer');
  const infoButtons = document.querySelectorAll('.info-toggle');
  const table = document.getElementById('team-table');
  let standardInner = '';
  const expandedInner = '<div class="expanded-row-header"></div><div class="expanded-row-body"></div>';

  infoButtons.forEach((infoButton) => {
    const correspondTablePlayer = document.getElementById(`${infoButton.dataset.playerid}`);
    infoButton.addEventListener('click', (event) => {
      if (correspondTablePlayer.classList.contains('row-expanded')) {
        correspondTablePlayer.classList.remove('row-expanded');
        correspondTablePlayer.innerHTML = standardInner;
        correspondTablePlayer.classList.add('row-hover-highlight');
        footballers.forEach((footballer) => {
          footballer.classList.remove('row-contracted');
        });
        const fixtures = document.querySelectorAll('.fixture')
        fixtures.forEach((fixture) => {
          fixture.classList.remove('small-font');
        });
      // Branch if the user clicks on a row not expanded, but another row IS expanded
      } else if (table.querySelector('.row-expanded') && correspondTablePlayer.classList.contains('row-contracted')) {
          table.querySelector('.row-expanded').innerHTML = standardInner;
          table.querySelector('.row-expanded').classList.add('row-contracted');
          table.querySelector('.row-expanded').classList.add('row-hover-highlight');
          table.querySelector('.row-expanded').classList.remove('row-expanded');
          standardInner = correspondTablePlayer.innerHTML;
          correspondTablePlayer.classList.add('row-expanded');
          const children = correspondTablePlayer.childNodes
          children.forEach((child) => {
            if (child instanceof HTMLDivElement) {
              child.classList.toggle('hidden')
            }
          })
          const footballerButton = document.getElementById(`footballer-details-${correspondTablePlayer.dataset.id}`);
          const footballerId = correspondTablePlayer.dataset.id;
          footballerButton.addEventListener('click', (buttonEvent) => {
            const modalArea = document.querySelector('.modal-body');
            modalArea.innerHTML = "";
            fetch(`/footballers/${footballerId}/modal`)
              .then(response => response.text())
              .then(html => {
                modalArea.insertAdjacentHTML('beforeend', html);
              });
          });
          if (correspondTablePlayer.news) {
            correspondTablePlayer.querySelector('.expanded-row-body').innerHTML = `<p class="news">${correspondTablePlayer.dataset.news}</p>`;
          }
          correspondTablePlayer.classList.remove('row-hover-highlight');
            // Branch if user clicks on a row and no rows are already expanded
          } else {
              footballers.forEach((footballer) => {
                footballer.classList.add('row-contracted');
              });
              const fixtures = document.querySelectorAll('.fixture');
              fixtures.forEach((fixture) => {
                fixture.classList.add('small-font');
              });
              correspondTablePlayer.classList.remove('row-contracted');
              standardInner = correspondTablePlayer.innerHTML;
              correspondTablePlayer.classList.add('row-expanded');
              const children = correspondTablePlayer.childNodes
              children.forEach((child) => {
                if (child instanceof HTMLDivElement) {
                  child.classList.toggle('hidden')
                }
              })
              const footballerButton = document.getElementById(`footballer-details-${correspondTablePlayer.dataset.id}`);
              const footballerId = correspondTablePlayer.dataset.id;
              footballerButton.addEventListener('click', (buttonEvent) => {
                const modalArea = document.querySelector('.modal-body');
                modalArea.innerHTML = "";
                fetch(`/footballers/${footballerId}/modal`)
                  .then(response => response.text())
                  .then(html => {
                    modalArea.insertAdjacentHTML('beforeend', html);
                  });
              });
              if (correspondTablePlayer.news) {
                correspondTablePlayer.querySelector('.expanded-row-body').innerHTML = `<p class="news">${correspondTablePlayer.dataset.news}</p>`;
              }
              correspondTablePlayer.classList.remove('row-hover-highlight');
          }
      });
  });

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
          const children = event.currentTarget.childNodes
          children.forEach((child) => {
            if (child instanceof HTMLDivElement) {
              child.classList.toggle('hidden')
            }
          })
          const footballerButton = document.getElementById(`footballer-details-${event.currentTarget.dataset.id}`);
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
          const children = event.currentTarget.childNodes
          children.forEach((child) => {
            if (child instanceof HTMLDivElement) {
              child.classList.toggle('hidden')
            }
          })
          const footballerButton = document.getElementById(`footballer-details-${event.currentTarget.dataset.id}`);
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
    const footballerId = footballer.dataset.id;
    footballer.addEventListener('click', (event) => {
      console.log(event.currentTarget);
      const expandedContent = document.getElementById(`expanded-content-${footballerId}`);
      expandedContent.classList.toggle('hidden');
      const footballerShowButton = document.getElementById(`footballer-details-${event.currentTarget.dataset.id}`);
      if (footballerShowButton) {
        footballerShowButton.addEventListener('click', () => {
          const modalArea = document.querySelector('.modal-body');
          modalArea.innerHTML = "";
          fetch(`/footballers/${footballerId}/modal`)
            .then(response => response.text())
            .then(html => {
              modalArea.insertAdjacentHTML('beforeend', html);
            });
        });
      }
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
          const footballerButton = event.currentTarget.querySelector('.see-footballer');
          const footballerInfo = event.currentTarget.querySelector('.footballer-info');
          if (footballerButton) {
            footballerButton.classList.toggle('hidden');
            footballerButton.addEventListener('click', (event) => {
              event.stopPropagation();
            });
          }
          if (footballerInfo) {
            footballerInfo.classList.add('player-info');
            footballerInfo.classList.remove('hidden');
          }
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
