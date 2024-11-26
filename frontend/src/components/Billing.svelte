<script>
  import { theme } from '../stores/theme.js';

  let currentPlan = 'Pro';
  let invoices = [
    { date: '2023-05-01', amount: 49.99, status: 'Paid' },
    { date: '2023-04-01', amount: 49.99, status: 'Paid' },
    { date: '2023-03-01', amount: 49.99, status: 'Paid' },
  ];

  let plans = [
    { name: 'Basic', price: 9.99, features: ['Contact form bypassing email to CRM', 'Up to 100 form submissions/month', 'Basic analytics'] },
    { name: 'Pro', price: 29.99, features: ['All Basic features', 'Custom landing page', 'Up to 1000 form submissions/month', 'Advanced analytics'] },
    { name: 'Enterprise', price: 99.99, features: ['All Pro features', 'AI-powered virtual assistant', 'Unlimited form submissions', 'Priority support', 'Custom integrations'] }
  ];

  function updatePaymentMethod() {
    alert('Updating payment method...');
  }

  function changePlan(planName) {
    alert(`Changing to ${planName} plan...`);
  }
</script>

<div class="billing" class:dark={$theme === 'dark'}>
  <h2>Billing Information</h2>
  <div class="billing-content">
    <div class="current-plan">
      <h3>Current Plan</h3>
      <p>You are currently on the <strong>{currentPlan}</strong> plan.</p>
    </div>

    <div class="plans">
      <h3>Available Plans</h3>
      <div class="plan-cards">
        {#each plans as plan}
          <div class="plan-card" class:current={plan.name === currentPlan}>
            <h4>{plan.name}</h4>
            <p class="price">${plan.price}/month</p>
            <ul>
              {#each plan.features as feature}
                <li>{feature}</li>
              {/each}
            </ul>
            <button on:click={() => changePlan(plan.name)}>
              {plan.name === currentPlan ? 'Current Plan' : 'Select Plan'}
            </button>
          </div>
        {/each}
      </div>
    </div>

    <div class="payment-method">
      <h3>Payment Method</h3>
      <p>Credit Card ending in 1234</p>
      <button on:click={updatePaymentMethod}>Update Payment Method</button>
    </div>

    <div class="invoices">
      <h3>Invoices</h3>
      <table>
        <thead>
          <tr>
            <th>Date</th>
            <th>Amount</th>
            <th>Status</th>
          </tr>
        </thead>
        <tbody>
          {#each invoices as invoice}
            <tr>
              <td>{invoice.date}</td>
              <td>${invoice.amount.toFixed(2)}</td>
              <td>{invoice.status}</td>
            </tr>
          {/each}
        </tbody>
      </table>
    </div>
  </div>
</div>

<style>
  .billing {
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
  }

  .billing-content {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  h3 {
    margin-top: 0;
  }

  .current-plan, .payment-method, .plans, .invoices {
    margin-bottom: 30px;
  }

  .plan-cards {
    display: flex;
    justify-content: space-between;
    gap: 20px;
    flex-wrap: wrap;
  }

  .plan-card {
    flex: 1;
    min-width: 200px;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    text-align: center;
  }

  .plan-card.current {
    border-color: #3498db;
    box-shadow: 0 0 10px rgba(52, 152, 219, 0.3);
  }

  .plan-card h4 {
    margin-top: 0;
  }

  .plan-card .price {
    font-size: 1.5em;
    font-weight: bold;
    margin: 10px 0;
  }

  .plan-card ul {
    text-align: left;
    padding-left: 20px;
    margin-bottom: 20px;
  }

  button {
    background-color: #3498db;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 4px;
    cursor: pointer;
  }

  button:hover {
    background-color: #2980b9;
  }

  table {
    width: 100%;
    border-collapse: collapse;
  }

  th, td {
    text-align: left;
    padding: 8px;
    border-bottom: 1px solid #ddd;
  }

  th {
    background-color: #f2f2f2;
    font-weight: bold;
  }

  .dark .billing-content {
    background-color: #2c3e50;
    color: #ecf0f1;
  }

  .dark .plan-card {
    background-color: #34495e;
    border-color: #2c3e50;
  }

  .dark .plan-card.current {
    border-color: #3498db;
    box-shadow: 0 0 10px rgba(52, 152, 219, 0.3);
  }

  .dark button {
    background-color: #2980b9;
  }

  .dark button:hover {
    background-color: #3498db;
  }

  .dark th {
    background-color: #34495e;
  }

  .dark th, .dark td {
    border-color: #34495e;
  }
</style>