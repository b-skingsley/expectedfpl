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

const runCountdown = () => {
  const countdownOutput = document.getElementById('deadline-countdown');
  let deadline = countdownOutput.dataset.gameweek;
  deadline = new Date(deadline)
  const timeNow = new Date();
  if (deadline - timeNow < 0) {
    deadline = countdownOutput.dataset.gameweek2;
    deadline = new Date(deadline)
  }
  const countdown = convertTime(deadline - timeNow);
  countdownOutput.innerText = countdown;
};

export { runCountdown };
