import App from './App.svelte';

const app = new App({
  target: document.getElementById('app'),
  props: {
    url: window.location.pathname
  }
});

// Enable client-side routing
window.addEventListener('click', e => {
  const el = e.target;
  if (el.tagName === 'A' && el.href.startsWith(window.location.origin)) {
    e.preventDefault();
    const url = new URL(el.href);
    window.history.pushState(null, '', url.pathname);
    window.dispatchEvent(new Event('popstate'));
  }
});

export default app;