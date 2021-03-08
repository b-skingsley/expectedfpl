const countdownOutput = document.getElementById('deadline-countdown');

const convertTime = (ms) => {
  let d, h, m, s;
  s = Math.floor(ms / 1000);
  m = Math.floor(s / 60);
  s = s % 60;
  h = Math.floor(m / 60);
  m = m % 60;
  d = Math.floor(h / 24);
  h = h % 24;

  if (d === 0 && hrs === 0) {
    return `${m} mins`;
  } else if (d === 0) {
    return `${h} hrs, ${m} mins`;
  } else {
    return `${d}days ${h}hrs ${m}mins`;
  }
};

const calculateTime = () => {
  let deadline = countdownOutput.dataset.gameweek;
  deadline = new Date(deadline)
  const timeNow = new Date();
  const countdown = convertTime(deadline - timeNow);
  countdownOutput.innerText = countdown;
};

const runCountdown = () => {
  calculateTime();
  setInterval(calculateTime, 60000);
};

export { runCountdown };
