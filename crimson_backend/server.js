// crimson_backend/server.js

const express = require('express');
const cors = require('cors');
const { mockPosts } = require('./data/mockPosts');
const { mockMembers } = require('./data/mockMembers');

const app = express();
const PORT = 3000;

// --- EDITED: Explicit CORS Configuration for Development ---
// This allows all origins ('*'), which fixes the "ClientException: Failed to fetch"
// error in the Chrome browser when the Flutter app is running on a different port.
app.use(cors({
    origin: '*', // Allows all origins (your Flutter web app's random debug port)
    methods: ['GET', 'POST', 'PUT', 'DELETE'],
}));
// -----------------------------------------------------------

app.use(express.json());

// API Endpoints
app.get('/api/posts', (req, res) => {
    setTimeout(() => {
        res.status(200).json(mockPosts);
    }, 500); 
});

app.get('/api/members', (req, res) => {
    setTimeout(() => {
        res.status(200).json(mockMembers);
    }, 300);
});

app.post('/api/posts', (req, res) => {
    const newPost = req.body;
    console.log('New post received:', newPost);
    
    const savedPost = { 
        id: 'p' + (mockPosts.length + 1), 
        ...newPost, 
        timestamp: new Date().toISOString() 
    };
    
    mockPosts.unshift(savedPost);
    
    res.status(201).json({ 
        message: 'Post created successfully!', 
        post: savedPost 
    });
});

app.listen(PORT, () => {
    console.log(`Crimson Backend Server running at http://localhost:${PORT}`);
    // Note: I updated this log message back to 10.0.2.2 as it's the standard for Android,
    // but the Flutter code MUST use 'localhost' when running in Chrome.
    console.log('Use http://10.0.2.2:3000 in Flutter Android Emulator to connect.');
});