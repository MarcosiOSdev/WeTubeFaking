var faker = require("faker");

var appRouter = function (app) {

var homeResponse = 
  [
  {
    "title": "Taylor Swift - I Knew You Were Trouble (Exclusive)",
    "number_of_views": 319644991,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg",
    "channel": {
      "name": "Taylor Fan Forever",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 210
  },
  {
    "title": "Rihanna Work featuring Drake",
    "number_of_views": 92839921,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_work.jpg",
    "channel": {
      "name": "Rihanna's Channel",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/rihanna_profile.jpg"
    },
    "duration": 189
  },
  {
    "title": "Beyonce - Put A Ring On It",
    "number_of_views": 52321223,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_put_a_ring_on_it.jpg",
    "channel": {
      "name": "Taylor Fan Forever",
      "profile_image_nåame": "https://s3-us-west-2.amazonaws.com/youtubeassets/beyonce_profile.jpg"
    },
    "duration": 410
  },
  {
    "title": "Kanye Interrupts Taylor Embarrassing Video",
    "number_of_views": 9999999999999,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye-interupts-taylor-zoom.jpg",
    "channel": {
      "name": "KanyeLover",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye_profile2.jpeg"
    },
    "duration": 80
  },
  {
    "title": "Rebecca Black - Friday",
    "number_of_views": 12312344,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/rebecca_black_friday.jpg",
    "channel": {
      "name": "Rebecca Black's Awesome",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/rebecca_black_profile.jpeg"
    },
    "duration": 232
  },
  {
    "title": "John Legend - All Of Me",
    "number_of_views": 334435123,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/john_legend_all_of_me.jpg",
    "channel": {
      "name": "@Lipeibca - Twitter",
      "profile_image_name": "https://pbs.twimg.com/profile_images/793094383696478209/iptZ18YN_400x400.jpg"
    },
    "duration": 301
  }
];

var subscriptionsResponse = [
  {
    "title": "Taylor Swift on Love: 'Happily Ever After Doesn't Happen in Real Life'",
    "number_of_views": 23456,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_on_love.jpg",
    "channel": {
      "name": "Taylor Fan Forever",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 286
  },
  {
    "title": "Drake - Hotline Bling",
    "number_of_views": 762630652,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/drake_hotline_bling.jpg",
    "channel": {
      "name": "Taylor Fan Forever",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 223
  },
  {
    "title": "I Knew You Were Trouble",
    "number_of_views": 319644991,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg",
    "channel": {
      "name": "Taylor Fan Forever",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 210
  }
];

var trendingResponse = [
  {
    "title": "Everything Wrong with Zootopia",
    "number_of_views": 319644991,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/zootopia.png",
    "channel": {
      "name": "CinemaSins",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 210
  },
  {
    "title": "Kanye West Keepin' It Real",
    "number_of_views": 762630652,
    "thumbnail_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/kanye-west-ellen-degeneres.jpg",
    "channel": {
      "name": "CinemaSins",
      "profile_image_name": "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg"
    },
    "duration": 223
  }
];

  app.get("/", function (req, res) {
    res.status(200).send({ message: 'Welcome to our restful API' });
  });

  app.get("/youtube", function (req, res) {    
    res.status(200).send("/home or /trending or /subscrible");
  });

  app.get("/youtube/home", function (req, res) {    
    res.status(200).send(homeResponse);
  });

  app.get("/youtube/trending", function (req, res) {    
    res.status(200).send(trendingResponse);
  });

  app.get("/youtube/subscriptions", function (req, res) {    
    res.status(200).send(subscriptionsResponse);
  });



 app.get("/users/:num", function (req, res) {
   var users = [];
   var num = req.params.num;

   if (isFinite(num) && num  > 0 ) {
     for (i = 0; i <= num-1; i++) {
       users.push({
           firstName: faker.name.firstName(),
           lastName: faker.name.lastName(),
           username: faker.internet.userName(),
           email: faker.internet.email()
        });
     }

     res.status(200).send(users);
    
   } else {
     res.status(400).send({ message: 'invalid number supplied' });
   }

 });
}

module.exports = appRouter;