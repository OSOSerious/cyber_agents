<script>
  import { onMount } from 'svelte';
  import { line, pie } from 'd3-shape';
  import { scaleLinear, scaleTime } from 'd3-scale';
  import { select } from 'd3-selection';
  import { axisBottom, axisLeft } from 'd3-axis';
  import { timeParse } from 'd3-time-format';

  let analyticsData = {
    totalContacts: 0,
    totalInteractions: 0,
    conversionRate: 0,
    recentActivity: [],
    csat: 0,
    nps: 0,
    clv: 0
  };
  let loading = true;
  let error = null;

  onMount(async () => {
    try {
      const response = await fetch('/api/analytics');
      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }
      analyticsData = await response.json();
      drawLineChart();
      drawPieChart();
    } catch (e) {
      console.error('Failed to fetch analytics data:', e);
      error = 'Failed to load analytics data. Please try again later.';
    } finally {
      loading = false;
    }
  });

  function drawLineChart() {
    const data = analyticsData.recentActivity.map(d => ({
      date: timeParse('%Y-%m-%d')(d.date),
      value: d.value
    }));

    const margin = { top: 20, right: 30, bottom: 30, left: 40 };
    const width = 800 - margin.left - margin.right;
    const height = 400 - margin.top - margin.bottom;

    const x = scaleTime()
      .domain(d3.extent(data, d => d.date))
      .range([0, width]);

    const y = scaleLinear()
      .domain([0, d3.max(data, d => d.value)])
      .nice()
      .range([height, 0]);

    const svg = select('#line-chart')
      .append('svg')
      .attr('width', width + margin.left + margin.right)
      .attr('height', height + margin.top + margin.bottom)
      .append('g')
      .attr('transform', `translate(${margin.left},${margin.top})`);

    svg.append('g')
      .attr('transform', `translate(0,${height})`)
      .call(axisBottom(x));

    svg.append('g')
      .call(axisLeft(y));

    svg.append('path')
      .datum(data)
      .attr('fill', 'none')
      .attr('stroke', 'steelblue')
      .attr('stroke-width', 1.5)
      .attr('d', line()
        .x(d => x(d.date))
        .y(d => y(d.value))
      );
  }

  function drawPieChart() {
    const data = [
      { label: 'Contacts', value: analyticsData.totalContacts },
      { label: 'Interactions', value: analyticsData.totalInteractions },
      { label: 'Conversions', value: analyticsData.conversionRate },
      { label: 'CSAT', value: analyticsData.csat },
      { label: 'NPS', value: analyticsData.nps },
      { label: 'CLV', value: analyticsData.clv }
    ];

    const width = 450;
    const height = 450;
    const radius = Math.min(width, height) / 2;

    const svg = select('#pie-chart')
      .append('svg')
      .attr('width', width)
      .attr('height', height)
      .append('g')
      .attr('transform', `translate(${width / 2},${height / 2})`);

    const pieGenerator = pie()
      .value(d => d.value);

    const arc = d3.arc()
      .innerRadius(0)
      .outerRadius(radius);

    const arcs = svg.selectAll('.arc')
      .data(pieGenerator(data))
      .enter()
      .append('g')
      .attr('class', 'arc');

    arcs.append('path')
      .attr('d', arc)
      .attr('fill', (d, i) => d3.schemeCategory10[i]);

    arcs.append('text')
      .attr('transform', d => `translate(${arc.centroid(d)})`)
      .attr('dy', '0.35em')
      .text(d => d.data.label);
  }
</script>

<div class="analytics-dashboard">
  <h2>Analytics Dashboard</h2>
  {#if loading}
    <p>Loading analytics data...</p>
  {:else if error}
    <p class="error">{error}</p>
  {:else}
    <div class="metrics-grid">
      <div class="metric-card">
        <h3>Total Contacts</h3>
        <p>{analyticsData.totalContacts}</p>
      </div>
      <div class="metric-card">
        <h3>Total Interactions</h3>
        <p>{analyticsData.totalInteractions}</p>
      </div>
      <div class="metric-card">
        <h3>Conversion Rate</h3>
        <p>{analyticsData.conversionRate}%</p>
      </div>
      <div class="metric-card">
        <h3>CSAT</h3>
        <p>{analyticsData.csat}</p>
      </div>
      <div class="metric-card">
        <h3>NPS</h3>
        <p>{analyticsData.nps}</p>
      </div>
      <div class="metric-card">
        <h3>CLV</h3>
        <p>{analyticsData.clv}</p>
      </div>
    </div>
    <div class="charts">
      <div id="line-chart"></div>
      <div id="pie-chart"></div>
    </div>
    <div class="recent-activity">
      <h3>Recent Activity</h3>
      {#if analyticsData.recentActivity.length > 0}
        <ul>
          {#each analyticsData.recentActivity as activity}
            <li>{activity}</li>
          {/each}
        </ul>
      {:else}
        <p>No recent activity to display.</p>
      {/if}
    </div>
  {/if}
</div>

<section>
  <h2>Real-Time Performance Tracking and Optimization</h2>
  <p>Contacting.AI offers real-time analytics on interaction performance, tracking conversions, engagement time, and customer satisfaction without the limitations of email open or click rates.</p>
</section>

<style>
  .analytics-dashboard {
    padding: 1rem;
  }

  .metrics-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 1rem;
    margin-bottom: 2rem;
  }

  .metric-card {
    background-color: #f0f0f0;
    border-radius: 8px;
    padding: 1rem;
    text-align: center;
  }

  .metric-card h3 {
    margin-top: 0;
  }

  .metric-card p {
    font-size: 2rem;
    font-weight: bold;
    margin: 0;
  }

  .charts {
    display: flex;
    justify-content: space-around;
    margin-bottom: 2rem;
  }

  #line-chart, #pie-chart {
    width: 45%;
  }

  .recent-activity ul {
    list-style-type: none;
    padding: 0;
  }

  .recent-activity li {
    margin-bottom: 0.5rem;
  }

  :global(.dark) .metric-card {
    background-color: #2a2a2a;
  }

  .error {
    color: #ff3e00;
    font-weight: bold;
  }
</style>
