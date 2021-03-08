const switchFunctionality = () => {
  const switches = document.querySelectorAll(".switch");
  const switch1 = document.getElementById("switch1");
  const switch2 = document.getElementById("switch2");
  const form = document.querySelector(".edit_team");
  let counter = 0;

  if (switches) {
    switches.forEach((button) => {
      if (counter === 0) {
        button.addEventListener('click', (event) => {
          const parent = event.currentTarget.parentElement;
          parent.classList.toggle("active");
          event.currentTarget.classList.toggle("selected");
          const secondParent = parent.parentElement;
          switch1.value = secondParent.dataset.id;
          if (secondParent.classList.contains("starting-player")) {
            if (secondParent.classList.contains("gk")) {
              const gkSwitch = document.querySelector(".bench-gk");
              gkSwitch.classList.toggle("active-button");
              gkSwitch.parentElement.classList.toggle("active2");
            } else {
              const benchSwitches = document.querySelectorAll(".bench-s");
              benchSwitches.forEach((benchSwitch) => {
                benchSwitch.classList.toggle("active-button");
                benchSwitch.parentElement.classList.toggle("active2");
              });
            }
          } else if (secondParent.classList.contains("bench-player")) {
            const defs = document.querySelectorAll(".s-def");
            const mids = document.querySelectorAll(".s-mid");
            const fwds = document.querySelectorAll(".s-fwd");
            console.log(defs.length)
            console.log(mids.length)
            console.log(fwds.length)
            if (secondParent.classList.contains("gk")) {
              const gkSwitch = document.querySelector(".gk-s");
              gkSwitch.classList.toggle("active-button");
              gkSwitch.parentElement.classList.toggle("active2");
            } else if (secondParent.classList.contains("def")) {
              // defs become active 2, mids become active 2, fwds only become active if at least 2 FWDs in team
              defs.forEach((def) => {
                def.classList.toggle("active-button");
                def.parentElement.classList.toggle("active2");
              });
              mids.forEach((mid) => {
                mid.classList.toggle("active-button");
                mid.parentElement.classList.toggle("active2");
              });
              if (fwds.length > 1) {
                fwds.forEach((fwd) => {
                  fwd.classList.toggle("active-button");
                  fwd.parentElement.classList.toggle("active2");
                });
              }
            } else if (secondParent.classList.contains("mid")) {
              // mids become active 2, defs become active 2 if there's 4-5 defs, fwds if at least 2 FWDs in team
              if (defs.length > 3) {
                defs.forEach((def) => {
                  def.classList.toggle("active-button");
                  def.parentElement.classList.toggle("active2");
                });
              }
              mids.forEach((mid) => {
                mid.classList.toggle("active-button");
                mid.parentElement.classList.toggle("active2");
              });
              if (fwds.length > 1) {
                fwds.forEach((fwd) => {
                  fwd.classList.toggle("active-button");
                  fwd.parentElement.classList.toggle("active2");
                });
              }
            } else {
              // fwds become active 2, defs become active 2 if there's 4-5 defs, mids become active 2
              if (defs.length > 3) {
                defs.forEach((def) => {
                  def.classList.toggle("active-button");
                  def.parentElement.classList.toggle("active2");
                });
              }
              mids.forEach((mid) => {
                mid.classList.toggle("active-button");
                mid.parentElement.classList.toggle("active2");
              });
              fwds.forEach((fwd) => {
                fwd.classList.toggle("active-button");
                fwd.parentElement.classList.toggle("active2");
              });
            };
          counter += 1;
          };
        });
      };
    });
  };
  if (counter === 1) {
    const activeButtons = querySelectorAll(".active-button")
    activeButtons.forEach((activeButton) => {
      activeButton.addEventListener('click', (event) => {
        const parent = event.currentTarget.parentElement;
        parent.classList.toggle("active");
        switch2.value = parent.parentElement.dataset.id;
        form.submit();
      })
    })
    const selectedButton = querySelector(".selected")
    selectedButton.addEventListener('click', (event) => {
      const parent = event.currentTarget.parentElement;
      parent.classList.toggle("active");
      counter -= 1;
      switch1.value = 0;
      location.reload();
    })
  };
};

export { switchFunctionality };
