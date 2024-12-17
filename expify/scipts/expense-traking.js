const form = document.getElementById("expense-form");
const expenseTable = document
  .getElementById("expense-table")
  .querySelector("tbody");
const filterSelect = document.getElementById("filter");
const totalExpensesElement = document.getElementById("total-expenses");

let expenses = [];
let expenseChart; // Chart instance

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

// Initialize the graph after DOM is loaded
document.addEventListener("DOMContentLoaded", () => {
  initializeGraph();
});
// Add Expense
form.addEventListener("submit", (e) => {
  e.preventDefault();

  const name = document.getElementById("expense-name").value;
  const amount = parseFloat(document.getElementById("expense-amount").value);
  const date = new Date(document.getElementById("expense-date").value); // Ensure conversion

  expenses.push({ name, amount, date });
  form.reset();
  console.log("Current expenses:", expenses);
  renderTable();
  updateSummary();
  updateGraph(); // Update graph
});

// Render Table
function renderTable() {
  expenseTable.innerHTML = "";

  const filteredExpenses = getFilteredExpenses();
  console.log("Filtered expenses for rendering:", filteredExpenses);
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
  const currentDate = new Date(now.setHours(0, 0, 0, 0));

  console.log("filter::", filter);
  console.log("now::", now);
  console.log("currentDate::", currentDate);

  if (filter === "daily") {
    return expenses.filter(
      (expense) => expense.date.toDateString() === currentDate.toDateString()
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
  updateGraph(); // Update graph on filter change
});

// Initialize Graph
function initializeGraph() {
  const ctx = document.getElementById("expense-chart").getContext("2d");
  expenseChart = new Chart(ctx, {
    type: "bar",
    data: {
      labels: [], // Dates
      datasets: [
        {
          label: "Total Expenses",
          data: [], // Amounts
          backgroundColor: "rgba(75, 192, 192, 0.2)",
          borderColor: "rgba(75, 192, 192, 1)",
          borderWidth: 1,
        },
      ],
    },
    options: {
      responsive: true,
      scales: {
        x: {
          title: {
            display: true,
            text: "Date",
          },
        },
        y: {
          title: {
            display: true,
            text: "Expense Amount",
          },
          beginAtZero: true,
        },
      },
    },
  });
}

// Update Graph
function updateGraph() {
  if (!expenseChart) {
    console.error("Chart is not initialized.");
    return;
  }
  const filteredExpenses = getFilteredExpenses();

  // Extract data for graph
  const labels = filteredExpenses.map(
    (expense) => expense.date.toISOString().split("T")[0]
  );
  const data = filteredExpenses.map((expense) => expense.amount);
  console.log("Graph labels:", labels);
  console.log("Graph data:", data);
  // Update chart data
  expenseChart.data.labels = labels;
  expenseChart.data.datasets[0].data = data;

  // Re-render the chart
  expenseChart.update();
}

// Initialize the graph on page load
initializeGraph();
