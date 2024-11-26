import { writable } from 'svelte/store';
import { navigate } from 'svelte-routing';

// Create stores for authentication state
export const isAuthenticated = writable(false);
export const user = writable(null);
export const token = writable(null);

// Helper functions for auth management
export function login(userData, authToken) {
  isAuthenticated.set(true);
  user.set(userData);
  token.set(authToken);
  
  // Store auth data in localStorage
  const authData = {
    user: userData,
    token: authToken,
    expiresAt: new Date().getTime() + (24 * 60 * 60 * 1000) // 24 hours from now
  };
  localStorage.setItem('auth', JSON.stringify(authData));
}

export function logout() {
  isAuthenticated.set(false);
  user.set(null);
  token.set(null);
  localStorage.removeItem('auth');
  navigate('/login');
}

// Check if token is expired
function isTokenExpired(expiresAt) {
  return new Date().getTime() > expiresAt;
}

// Initialize auth state from localStorage
const storedAuth = localStorage.getItem('auth');
if (storedAuth) {
  const authData = JSON.parse(storedAuth);
  if (!isTokenExpired(authData.expiresAt)) {
    isAuthenticated.set(true);
    user.set(authData.user);
    token.set(authData.token);
  } else {
    // Clear expired auth data
    localStorage.removeItem('auth');
  }
}

// Middleware for protected routes
export function requireAuth() {
  const unsubscribe = isAuthenticated.subscribe(value => {
    if (!value) {
      navigate('/login', { replace: true });
    }
  });
  unsubscribe();
}

// Middleware for auth pages (login/signup)
export function requireNoAuth() {
  const unsubscribe = isAuthenticated.subscribe(value => {
    if (value) {
      navigate('/dashboard', { replace: true });
    }
  });
  unsubscribe();
}
