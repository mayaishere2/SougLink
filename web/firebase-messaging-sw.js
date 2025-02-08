importScripts('https://www.gstatic.com/firebasejs/10.7.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.2/firebase-messaging-compat.js');

firebase.initializeApp({
    apiKey: "AIzaSyDl05Wfav1tN5ijr44WOp_ZjI0C154KvV0",
    authDomain: "SougLink.firebaseapp.com",
    projectId: "souglink-9df24",
    storageBucket: "SougLink.appspot.com",
    messagingSenderId: "763894853613",
    appId: "1:763894853613:android:d83c6acb98ce59c4b8c1e4",
});

const messaging = firebase.messaging();

// Background message handler
messaging.onBackgroundMessage((payload) => {
    console.log("Received background message ", payload);

    self.registration.showNotification(payload.notification.title, {
        body: payload.notification.body,
        icon: '/icons/icon-192x192.png'
    });
});
