// Sign-up and Sign-in button logic
const signUpButton = document.getElementById("signUp");
const signInButton = document.getElementById("signIn");
const container = document.getElementById("container");

signUpButton.addEventListener("click", () => {
  container.classList.add("right-panel-active");
  console.log("sign up");
});

signInButton.addEventListener("click", () => {
  container.classList.remove("right-panel-active");
  console.log("sign in");
});

// Registration form logic
document
  .getElementById("registerBtn")
  .addEventListener("click", function (event) {
    event.preventDefault(); // Prevent form submission

    // Capture input values
    const name = document.getElementById("nameInput").value;
    const email = document.getElementById("emailInput").value;
    const password = document.getElementById("passwordInput").value;

    let userRegister = {
      name: name,
      email: email,
      password: password,
    };

    console.log("user-register::", userRegister);
    localStorage.setItem("new-user", JSON.stringify(userRegister));
  });

document.getElementById("loginBtn").addEventListener("click", function (event) {
  console.log("LOGIN CLICK");

  // event.preventDefault();

  const loginEmailInput = document.getElementById("signInEmailInput").value;
  const loginPwdInput = document.getElementById("singnInPwdInput").value;

  if (localStorage.getItem("new-user")) {
    let singupDetails = localStorage.getItem("new-user");
    let parseSingupDetails = JSON.parse(singupDetails);
    if (
      parseSingupDetails.email == loginEmailInput &&
      parseSingupDetails.password == loginPwdInput
    ) {
      //sypyna@mailinator.com
      // Pa$$w0rd!
      console.log("USER LOGGED IN SUCCESSFULLY");
      window.location.href = "homepage.html";
    } else {
      console.log("INVALID CREDENTIALS");
    }
  } else {
    console.log("USER DOES NOT EXIST");
  }
});