// Update the current slider value (each time you drag the slider handle)
const rangeValue = () => {
  const maxPriceSlider = document.getElementById("filter_by_max_price");
  const sliderValue = document.getElementById("max-price-value");
  if (sliderValue) sliderValue.innerHTML = maxPriceSlider.value; // Display the default slider value
  if (maxPriceSlider) {
    maxPriceSlider.addEventListener("input", (_event) => {
      sliderValue.innerHTML = maxPriceSlider.value;
    });
  }
};

export { rangeValue };
