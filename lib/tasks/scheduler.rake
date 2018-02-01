desc "This task is called by the Heroku scheduler add-on"
task :test_scheduler => :environment do
  puts "scheduler test"
  puts "it works."
end

task :update_rates => :environment do
  ENV["SSL_CERT_FILE"] = "app/controllers/cacert.pem"
    require 'open-uri'

    sources = ["USD","JPY","EUR","CNY", "KRW","THB", "VND", "SGD", "PHP"]
    currencies = sources.join(',')
    sources.each do |source|
        res = open('https://apilayer.net/api/live?access_key=356b689f4db8b2616a786c31a7023829&currencies=' + currencies + '&source=' + source + '&format=1')
        code, message = res.status # res.status => ["200", "OK"]
        if code == '200'
          result = ActiveSupport::JSON.decode res.read
          # resultを使ってなんやかんや処理をする
          result = result['quotes'] #返ってきたjsonデータをrubyの配列に変換
          result.each do |key, value|
            rate = Exchange.find_or_create_by(currency: key)
            rate.update(currency: key, rate: value)
              # if Exchange.find_by(currency: key)
              #   rate = Exchange.find_by(currency: key)
              #   rate.update(rate: value)
              # else
              #   Exchange.create(currency: key, rate: value)
              # end
          end
        else
          puts "Error!! #{code} #{message}"
        end
          puts result
      end
end

task :delete_old_posts => :environment do
  require 'time'
  n = Time.now
  oldTime = n - 1800
  puts n
  puts oldTime

  deletePosts = Post.where(["updated_at < ?", oldTime])
  p deletePosts
  deletePosts.destroy_all
  p "done"

#TODO：要テスト(asyncの環境だとtask内でactionCableが使えない可能性あり。redis環境では使えたとの記事あり。jobに処理を移してテストしたが動かない。)
  # deletePostsId = deletePosts.pluck(:user_id)
  # p deletePostsId
  # deletePostsId.each do |delete|
  #   p delete
  #   DeleteBroadcastJob.perform_now delete
  #   # p ActionCable.server.broadcast 'delete_channel', id: delete, userId: ""
  # end
  #
  # p "done"
end
