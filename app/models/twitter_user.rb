class TwitterUser < ActiveRecord::Base
  
  def self.get_twitter_json(uri, opts = {}) # :symbolize_keys => true | false
      puts "*** Getting JSON from Twitter ::: URI = #{uri}, domain = #{opts[:domain]}, symbolize_keys = #{opts[:symbolize_keys]}, authenticate = #{opts[:authenticate]}"
      Net::HTTP.start(opts[:domain] || "twitter.com") {|http|
        req = Net::HTTP::Get.new(uri)

        # changes API calls every minute, loops btwn 3 options
        #if Time.now.min%3 == 0 && opts[:authenticate] != true
        #  puts "using IP API calls"
        #elsif Time.now.min%2 == 0
      	#	req.basic_auth 'cheddrme', '42Ch3ddr!'
      	#	puts "using cheddrmedia API calls"
    		#else
    		#  req.basic_auth 'cheddr_app', '42Twitter!'
        #  puts "using cheddr_app API calls"
      	#end

        response = http.request(req)

        if response.code == "404" || response.code == "500" || response.code == "502" || response.code == "503"
          logger.error("ERROR getting Twitter JSON ::: URI = #{uri} ::: Response Code = #{response.code}")
        else
          begin
          return Yajl::Parser.new(:symbolize_keys => opts[:symbolize_keys]).parse(response.body)
          rescue Exception => e
            logger.error("ERROR parsing JSON with Yajl: #{e.message}")
            return {}
          end
        end
      }
    end
  
end
# == Schema Information
#
# Table name: twitter_users
#
#  id         :integer         not null, primary key
#  created_at :datetime
#  updated_at :datetime
#

