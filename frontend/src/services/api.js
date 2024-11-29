const API_URL = 'http://localhost:4000/api';

async function handleResponse(response) {
    if (!response.ok) {
        const error = await response.json();
        throw new Error(error.message || 'Something went wrong');
    }
    return response.json();
}

export const api = {
    // Interactions
    async getInteractions(page = 1, perPage = 20) {
        const response = await fetch(`${API_URL}/interactions?page=${page}&per_page=${perPage}`);
        return handleResponse(response);
    },

    async createInteraction(data) {
        const response = await fetch(`${API_URL}/interaction`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });
        return handleResponse(response);
    },

    // Analytics
    async getAnalytics() {
        const response = await fetch(`${API_URL}/analytics`);
        return handleResponse(response);
    },

    async getInteractionStats() {
        const response = await fetch(`${API_URL}/analytics/interactions`);
        return handleResponse(response);
    },

    async getContactStats() {
        const response = await fetch(`${API_URL}/analytics/contacts`);
        return handleResponse(response);
    },

    // Contacts
    async getContacts() {
        const response = await fetch(`${API_URL}/contacts`);
        return handleResponse(response);
    },

    async createContact(data) {
        const response = await fetch(`${API_URL}/contacts`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });
        return handleResponse(response);
    },

    async updateContact(id, data) {
        const response = await fetch(`${API_URL}/contacts/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data),
        });
        return handleResponse(response);
    },

    async deleteContact(id) {
        const response = await fetch(`${API_URL}/contacts/${id}`, {
            method: 'DELETE',
        });
        return handleResponse(response);
    }
};
