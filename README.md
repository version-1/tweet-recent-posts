# tweet-recent-posts

Bot tool for wordpress.
Bot choose one post from rencently posts and tweet randomly.


# how to install

1. clone this repository
 ```git clone https://github.com/version-1/tweet-recent-posts.git```

2. nake app.yml from app.yml.sample according to your environment

``` cp config/app.yml.sample config/app.yml ```

app.yml. sample

```
# database configuration
database:
    host: localhost
    username: <username>
    password: <password>
    database: <database>

# twitter oauth key
twitter:
    consumer_key: <consumer_key>
    consumer_secret: <consumer_secret>
    access_token: <access_token>
    access_token_secret: <access_token_secret>

# range of recent posts
# if you set 20, bot chose one post from recently 20 posts randomly
limit: 20

# your site url
site_url: <your site url>

```

3. tweet

```./tweet-resent-post.sh```
