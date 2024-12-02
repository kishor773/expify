const form = document.getElementById("expense-form");
const expenseTable = document
  .getElementById("expense-table")
  .querySelector("tbody");
const filterSelect = document.getElementById("filter");
const totalExpensesElement = document.getElementById("total-expenses");

let expenses = [];

// Add Expense
form.addEventListener("submit", (e) => {
  e.preventDefault();

  const name = document.getElementById("expense-name").value;
  const amount = parseFloat(document.getElementById("expense-amount").value);
  const date = new Date(document.getElementById("expense-date").value);
  console.log(name, amount, date);

  expenses.push({ name, amount, date });
  form.reset();

  renderTable();
  updateSummary();
});

// Render Table
function renderTable() {
  expenseTable.innerHTML = "";

  const filteredExpenses = getFilteredExpenses();
  filteredExpenses.forEach((expense) => {
    const row = document.createElement("tr");
    row.innerHTML = `
      <td>${expense.name}</td>
      <td>${expense.amount.toFixed(2)}</td>
      <td>${expense.date.toISOString().split("T")[0]}</td>
    `;
    expenseTable.appendChild(row);
  });
}

// Get Filtered Expenses
function getFilteredExpenses() {
  const filter = filterSelect.value;
  const now = new Date();

  if (filter === "daily") {
    return expenses.filter(
      (expense) => expense.date.toDateString() === now.toDateString()
    );
  } else if (filter === "monthly") {
    return expenses.filter(
      (expense) =>
        expense.date.getFullYear() === now.getFullYear() &&
        expense.date.getMonth() === now.getMonth()
    );
  } else if (filter === "yearly") {
    return expenses.filter(
      (expense) => expense.date.getFullYear() === now.getFullYear()
    );
  }

  return expenses;
}

// Update Summary
function updateSummary() {
  const filteredExpenses = getFilteredExpenses();
  const total = filteredExpenses.reduce(
    (sum, expense) => sum + expense.amount,
    0
  );
  totalExpensesElement.textContent = total.toFixed(2);
}

// Filter Change
filterSelect.addEventListener("change", () => {
  renderTable();
  updateSummary();
});
