const express = require('express');
const admin = require('firebase-admin');
const router = express.Router();

router.post('/register', async (req, res) => {
  try {
    const { email, password, username } = req.body;
    
    const userRecord = await admin.auth().createUser({
      email,
      password,
      displayName: username
    });

    // Create user document in Firestore
    await admin.firestore().collection('users').doc(userRecord.uid).set({
      username,
      email,
      createdAt: new Date(),
      profileImage: '',
      membership: 'basic'
    });

    res.status(201).json({ message: 'User created successfully', uid: userRecord.uid });
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

module.exports = router;