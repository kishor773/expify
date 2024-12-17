const buttons = document.querySelectorAll("[data-target]");
buttons.forEach((button) => {
  button.addEventListener("click", () => {
    const targetPage = button.getAttribute("data-target");
    console.log(targetPage);
    if (targetPage) {
      window.location.href = targetPage;
    }
  });
});