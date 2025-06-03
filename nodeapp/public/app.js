async function callApi(endpoint) {
  const output = document.getElementById("output");
  output.textContent = "Loading...";
  try {
    const res = await fetch(endpoint);
    const text = await res.text();
    output.textContent = text;
  } catch (err) {
    output.textContent = "❌ Error: " + err.message;
  }
}
