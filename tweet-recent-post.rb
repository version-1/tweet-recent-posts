require 'yaml'
require 'mysql2'
require 'oauth'
require 'json'
require './classes/autoload.rb'

yaml = YAML.load_file('./config/app.yml')
raise 'invalid configuration..' if yaml['site_url'].nil? || yaml['limit'].nil?

db = DBConfig.new(yaml['database'])
tw = TwitterConfig.new(yaml['twitter'])

client = Mysql2::Client.new(db.to_hash)

query = "select * from wp_posts where post_status ='publish' and post_type = 'post' order by post_date desc limit ?,1"
stmt = client.prepare(query)
idx = rand(yaml['limit'].to_i ) + 1
results = stmt.execute(idx)

if results.count < 1
    raise 'no query results ..'
end

msg = "最近の投稿\n\n"
msg << "#{results.first['post_title']}\n"
msg << "#{yaml['site_url']}/#{results.first['post_name']}"

twitter = Twitter.new(tw.to_hash)
response = twitter.tweet(msg)
unless response['text'].nil?
    p '==== Tweet ===='
    p response['created_at']
    p ''
    p response['text']
end
