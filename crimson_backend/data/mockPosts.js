// crimson_backend/data/mockPosts.js

const _placeholderImagePaths = [
    'images/enhypen_1.jpg', 'images/enhypen_2.jpeg', 'images/enhypen_3.jpeg',
    'images/enhypen_4.jpeg', 'images/enhypen_5.jpeg', 'images/enhypen_6.jpeg',
    'images/enhypen_7.jpeg', 'images/enhypen_8.jpeg', 'images/enhypen_9.jpeg',
    'images/enhypen_10.jpeg',
];

const dateFromHoursAgo = (hours, minutes = 0) => {
    const date = new Date();
    date.setHours(date.getHours() - hours);
    date.setMinutes(date.getMinutes() - minutes);
    return date.toISOString();
};

const dateFromDaysAgo = (days, hours = 0) => {
    const date = new Date();
    date.setDate(date.getDate() - days);
    date.setHours(date.getHours() - hours);
    return date.toISOString();
};


const mockPosts = [
    {
        id: 'p001', userId: 'u101', username: 'ENHYPEN_Official', userAvatarUrl: 'assets/avatars/official.png',
        imageUrl: _placeholderImagePaths[0],
        caption: 'Engene, thank you for another incredible week! Hope you enjoy the new updates and the behind-the-scenes content coming soon! 🧡 We are working hard! #ENHYPEN #ENGENE',
        timestamp: dateFromHoursAgo(1, 20),
        likes: 153456, comments: 5412, isLiked: true,
    },
    {
        id: 'p002', userId: 'u102', username: 'CrimsonUpdates', userAvatarUrl: 'assets/avatars/fan_news.png',
        imageUrl: _placeholderImagePaths[1],
        caption: 'Did anyone else catch the recent livestream? The new choreography looks intense! Ready for the comeback! ✨ Don\'t forget to vote! #CrimsonFan #KPop',
        timestamp: dateFromHoursAgo(3, 55),
        likes: 2450, comments: 310, isLiked: false,
    },
    {
        id: 'p003', userId: 'u103', username: 'JUNGWON_Official', userAvatarUrl: 'assets/avatars/jungwon.png',
        imageUrl: _placeholderImagePaths[2],
        caption: 'Practice is over! I hope you all are having a great day. Stay warm and don\'t forget to eat well! 🌙 See you soon Engenes!',
        timestamp: dateFromHoursAgo(5, 5),
        likes: 98000, comments: 4200, isLiked: true,
    },
    {
        id: 'p004', userId: 'u104', username: 'EngeneForever', userAvatarUrl: 'assets/avatars/fan_pfp.png',
        imageUrl: _placeholderImagePaths[3],
        caption: 'My new wallpaper is everything! I can\'t stop looking at this concept photo. Which version is your favorite? Post yours below! 👇',
        timestamp: dateFromHoursAgo(9, 40),
        likes: 780, comments: 150, isLiked: false,
    },
    {
        id: 'p005', userId: 'u105', username: 'SUNOO_Official', userAvatarUrl: 'assets/avatars/sunoo.png',
        imageUrl: _placeholderImagePaths[4],
        caption: 'Eating something yummy after a long day of filming! This is my favorite dessert! 😋 So delicious! ✌️',
        timestamp: dateFromDaysAgo(1, 2),
        likes: 85000, comments: 3500, isLiked: false,
    },
    {
        id: 'p006', userId: 'u106', username: 'JAY_Official', userAvatarUrl: 'assets/avatars/jay.png',
        imageUrl: _placeholderImagePaths[5],
        caption: 'Working on some new music arrangements today. Can\'t wait to share it with everyone! 🎵 Stay patient, Engene! 🎸',
        timestamp: dateFromDaysAgo(2, 15),
        likes: 77000, comments: 3100, isLiked: true,
    },
    {
        id: 'p007', userId: 'u107', username: 'CrimsonCollector', userAvatarUrl: 'assets/avatars/collector.png',
        imageUrl: _placeholderImagePaths[6],
        caption: 'Finally completed my photocards for the latest album! It took so much trading but it was worth it! So proud! #KPopCollection',
        timestamp: dateFromDaysAgo(3, 4),
        likes: 320, comments: 75, isLiked: false,
    },
];

module.exports = { mockPosts };