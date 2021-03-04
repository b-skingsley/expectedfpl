const maxPriceSlider = document.getElementById("filter_by_max_price");
const sliderValue = document.getElementById("max-price-value");
sliderValue.innerHTML = maxPriceSlider.value; // Display the default slider value

// Update the current slider value (each time you drag the slider handle)
const rangeValue = () => {
  maxPriceSlider.addEventListener("input", (_event) => {
    sliderValue.innerHTML = maxPriceSlider.value;
  });
};

export { rangeValue };
