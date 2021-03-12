const clipDifficultyBar = () => {
    const difficultyBars = document.querySelectorAll("#difficulty-bar");
    difficultyBars.forEach((difficultyBar) => {
        console.log(difficultyBar);
        difficultyBar.style.clip = `rect(0px,${difficultyBar.dataset.difficulty}px,108px,0px)`;
    });
};

export { clipDifficultyBar };