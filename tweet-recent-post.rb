require 'yaml'
#require 'mysql2'
require 'mysql'
require 'oauth'
#require 'json'
require './classes/autoload.rb'

yaml = YAML.load_file('./config/app.yml')
raise 'invalid configuration..' if yaml['site_url'].nil? || yaml['limit'].nil?

db = DBConfig.new(yaml['database'])
tw = TwitterConfig.new(yaml['twitter'])


query = "select post_title, post_name from wp_posts where post_status ='publish' and post_type = 'post' order by post_date desc limit ?,1"
idx = rand(yaml['limit'].to_i ) + 1
my = Mysql.connect(db.host, db.user, db.password, db.database)
stmt = my.prepare(query)
results = stmt.execute(idx) 

if results.size != 1
    raise 'unexpected query results ..'
end

msg = "最近の投稿\n\n"
results.each do |post_title, post_name|
    msg << "#{post_title}\n"
    msg << "#{yaml['site_url']}/#{post_name}"
end

twitter = Twitter.new(tw.to_hash)
response = twitter.tweet(msg)
if response
    p '==== Tweet ===='
    p ''
    p msg 
end
