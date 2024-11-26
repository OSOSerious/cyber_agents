<script>
  import { onMount } from 'svelte';
  import { theme } from '../stores/theme.js';

  let currentDate = new Date();
  let selectedDate = null;
  let appointments = [];

  const daysInMonth = (year, month) => new Date(year, month + 1, 0).getDate();
  const firstDayOfMonth = (year, month) => new Date(year, month, 1).getDay();

  $: calendarDays = getCalendarDays(currentDate.getFullYear(), currentDate.getMonth());

  function getCalendarDays(year, month) {
    const days = [];
    const totalDays = daysInMonth(year, month);
    const firstDay = firstDayOfMonth(year, month);

    for (let i = 0; i < firstDay; i++) {
      days.push(null);
    }

    for (let i = 1; i <= totalDays; i++) {
      days.push(new Date(year, month, i));
    }

    return days;
  }

  function prevMonth() {
    currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth() - 1, 1);
  }

  function nextMonth() {
    currentDate = new Date(currentDate.getFullYear(), currentDate.getMonth() + 1, 1);
  }

  function selectDate(date) {
    if (date) {
      selectedDate = date;
      newAppointment.date = date.toISOString().split('T')[0];
    }
  }

  let newAppointment = {
    title: '',
    date: null,
    time: ''
  };

  function addAppointment() {
    if (newAppointment.title && newAppointment.date && newAppointment.time) {
      appointments = [...appointments, { ...newAppointment }];
      newAppointment = { title: '', date: null, time: '' };
    }
  }

  function removeAppointment(index) {
    appointments = appointments.filter((_, i) => i !== index);
  }

  onMount(() => {
    // Fetch appointments from API or load from storage
    appointments = [
      { title: "Meeting with Alice", date: "2023-10-01", time: "14:00" },
      { title: "Call with Bob", date: "2023-10-02", time: "10:00" },
      { title: "Lunch with Carol", date: "2023-10-05", time: "12:30" }
    ];
  });
</script>

<div class="interaction-point" class:dark={$theme === 'dark'}>
  <div class="calendar-container">
    <h2>Calendar</h2>
    <div class="calendar">
      <div class="calendar-header">
        <button on:click={prevMonth}>&lt;</button>
        <h3>{currentDate.toLocaleString('default', { month: 'long', year: 'numeric' })}</h3>
        <button on:click={nextMonth}>&gt;</button>
      </div>
      <div class="calendar-grid">
        <div class="weekday">Su</div>
        <div class="weekday">Mo</div>
        <div class="weekday">Tu</div>
        <div class="weekday">We</div>
        <div class="weekday">Th</div>
        <div class="weekday">Fr</div>
        <div class="weekday">Sa</div>
        {#each calendarDays as day}
          {#if day}
            <div 
              class="day" 
              class:selected={selectedDate && day.toDateString() === selectedDate.toDateString()}
              class:today={day.toDateString() === new Date().toDateString()}
              on:click={() => selectDate(day)}
            >
              {day.getDate()}
            </div>
          {:else}
            <div class="day empty"></div>
          {/if}
        {/each}
      </div>
    </div>
  </div>

  <div class="appointment-container">
    <h2>Add Appointment</h2>
    <div class="appointment-form">
      <input 
        type="text" 
        placeholder="Appointment Title" 
        bind:value={newAppointment.title}
      >
      <input 
        type="date" 
        bind:value={newAppointment.date}
      >
      <select bind:value={newAppointment.time}>
        <option value="">Select a time</option>
        {#each Array(24).fill().map((_, i) => i) as hour}
          <option value={`${hour.toString().padStart(2, '0')}:00`}>
            {hour.toString().padStart(2, '0')}:00
          </option>
        {/each}
      </select>
      <button on:click={addAppointment}>Schedule Appointment</button>
    </div>

    <div class="upcoming-appointments">
      <h3>Upcoming Appointments</h3>
      {#each appointments as appointment, i}
        <div class="appointment">
          <span class="appointment-title">{appointment.title}</span>
          <span class="appointment-datetime">
            {new Date(appointment.date).toLocaleDateString()}, {appointment.time}
          </span>
          <button class="remove-appointment" on:click={() => removeAppointment(i)}>×</button>
        </div>
      {/each}
    </div>
  </div>
</div>

<section>
  <h2>Converting Traffic into Revenue Without Email Dependency</h2>
  <p>Contacting.AI maximizes revenue potential by converting traffic into immediate POCs, reducing delays and improving conversion rates.</p>
</section>

<style>
  .interaction-point {
    display: flex;
    max-width: 1000px;
    margin: 0 auto;
    padding: 20px;
    gap: 20px;
  }

  .calendar-container, .appointment-container {
    flex: 1;
  }

  .calendar {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .calendar-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
  }

  .calendar-grid {
    display: grid;
    grid-template-columns: repeat(7, 1fr);
    gap: 5px;
  }

  .weekday {
    text-align: center;
    font-weight: bold;
    padding: 5px;
    color: #777;
  }

  .day {
    text-align: center;
    padding: 10px;
    cursor: pointer;
    border-radius: 50%;
  }

  .day:hover {
    background-color: #f0f0f0;
  }

  .day.empty {
    cursor: default;
  }

  .day.selected {
    background-color: #3498db;
    color: white;
  }

  .day.today {
    border: 2px solid #3498db;
  }

  .appointment-form {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
    margin-bottom: 20px;
  }

  .appointment-form input, .appointment-form select {
    display: block;
    width: 100%;
    margin-bottom: 10px;
    padding: 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .appointment-form button {
    width: 100%;
    padding: 10px;
    background-color: #3498db;
    color: white;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .upcoming-appointments {
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    padding: 20px;
  }

  .appointment {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 10px;
    border-bottom: 1px solid #ddd;
  }

  .appointment:last-child {
    border-bottom: none;
  }

  .appointment-title {
    font-weight: bold;
  }

  .appointment-datetime {
    color: #777;
  }

  .remove-appointment {
    background: none;
    border: none;
    color: #e74c3c;
    cursor: pointer;
    font-size: 1.2em;
  }

  .dark .calendar, .dark .appointment-form, .dark .upcoming-appointments {
    background-color: #2c3e50;
    color: #ecf0f1;
  }

  .dark .day:hover {
    background-color: #34495e;
  }

  .dark .appointment-form input, .dark .appointment-form select {
    background-color: #34495e;
    color: #ecf0f1;
    border-color: #2c3e50;
  }

  .dark .appointment-datetime {
    color: #bdc3c7;
  }

  @media (max-width: 768px) {
    .interaction-point {
      flex-direction: column;
    }

    .calendar-container, .appointment-container {
      width: 100%;
    }

    .calendar {
      padding: 10px;
    }

    .day {
      padding: 5px;
    }

    .appointment-form input, .appointment-form select {
      padding: 8px;
    }
  }
</style>
