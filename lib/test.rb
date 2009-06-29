require 'honstats'

# 676 - Limi
# 685 - Kaution
# 586 - Kerian
# 288 - Killy
# 1109 - Gonzo
# 1067 - Calvin
# 499 - Rob
# 790 - Jeni
# 515 - Acid

honstats = HonStats::API.new
#chars = honstats.search_characters("K")
#chars.each do |char|
#  puts char.account.inspect
#end
#honstats.login("Limi", "f6fdffe48c908deb0f4c3bd36c032e72")
#games = honstats.get_active_games
#games.each do |g|
#  puts g.to_s
#  puts "rs => #{g.modes.rs}"
#  puts g.inspect
#  puts "\n"
#end
#char = honstats.get_character(676)
#puts "Level " + char.gamestats.level.to_s
#puts "ID " + char.account.id.to_s
#puts char.gamestats.xp_earned_per_minute

# ServerList = Gametype 90
# OnGoing = Gametype 32
# Browser = Gametype 10


stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"new_buddy", "account_id"=>"288", "buddy_id"=>"288"})
puts stuff.body

#stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"remove_buddy", "account_id"=>"288", "buddy_id"=>"676"})
#puts stuff.body

#stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"auth", "login"=>"UKTest1", "password"=>"f6fdffe48c908deb0f4c3bd36c032e72"})
#puts stuff.body

#stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"server_list", "gametype"=>"32", "cookie"=>"#{HonStats::API.get_data("cookie", stuff.body)}"})
#puts stuff.body

#stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"nick2id", "nickname[0]"=>"USTest1"})
#puts stuff.body

#stuff = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"get_all_stats", "account_id[0]"=>"676"})
#puts stuff.body

#data = Net::HTTP.post_form(URI.parse("http://masterserver.hon.s2games.com/client_requester.php"), {"f"=>"autocompleteNicks", "nickname"=>""})
#puts data.body

#data = 'a:2:{i:0;b:1;s:11:"server_list";a:3:{i:7;a:38:{s:9:"server_id";s:1:"7";s:7:"session";s:32:"ca83a4d9580838c1135dc609041a58b3";s:5:"mname";s:0:"";s:5:"class";s:1:"1";s:7:"private";s:1:"0";s:2:"nm";s:1:"1";s:2:"sd";s:1:"0";s:2:"rd";s:1:"0";s:2:"dm";s:1:"0";s:6:"league";s:1:"0";s:11:"max_players";s:1:"5";s:4:"tier";s:1:"1";s:8:"priv_key";s:0:"";s:9:"no_repick";s:1:"1";s:6:"no_agi";s:1:"1";s:7:"drp_itm";s:1:"1";s:8:"no_timer";s:1:"1";s:6:"rev_hs";s:1:"1";s:7:"no_swap";s:1:"1";s:6:"no_int";s:1:"1";s:8:"alt_pick";s:1:"1";s:4:"veto";s:1:"1";s:4:"shuf";s:1:"1";s:6:"no_str";s:1:"1";s:7:"no_pups";s:1:"1";s:5:"dup_h";s:1:"1";s:2:"ap";s:1:"1";s:2:"ar";s:1:"1";s:2:"em";s:1:"1";s:2:"rs";s:1:"1";s:2:"nl";s:1:"1";s:6:"officl";s:1:"1";s:2:"ip";s:14:"71.202.181.116";s:4:"port";s:5:"11235";s:8:"num_conn";s:1:"0";s:7:"c_state";s:1:"2";s:8:"last_upd";s:19:"2009-05-20 15:07:28";s:8:"location";s:3:"Unk";}i:150;a:38:{s:9:"server_id";s:3:"150";s:7:"session";s:32:"8df134f32ca4996dab404d4f161073a5";s:5:"mname";s:14:"Fricket\'s Game";s:5:"class";s:1:"1";s:7:"private";s:1:"0";s:2:"nm";s:1:"0";s:2:"sd";s:1:"0";s:2:"rd";s:1:"1";s:2:"dm";s:1:"0";s:6:"league";s:1:"0";s:11:"max_players";s:1:"5";s:4:"tier";s:1:"1";s:8:"priv_key";s:0:"";s:9:"no_repick";s:1:"0";s:6:"no_agi";s:1:"0";s:7:"drp_itm";s:1:"0";s:8:"no_timer";s:1:"0";s:6:"rev_hs";s:1:"0";s:7:"no_swap";s:1:"0";s:6:"no_int";s:1:"0";s:8:"alt_pick";s:1:"0";s:4:"veto";s:1:"0";s:4:"shuf";s:1:"0";s:6:"no_str";s:1:"0";s:7:"no_pups";s:1:"0";s:5:"dup_h";s:1:"0";s:2:"ap";s:1:"1";s:2:"ar";s:1:"0";s:2:"em";s:1:"0";s:2:"rs";s:1:"0";s:2:"nl";s:1:"1";s:6:"officl";s:1:"1";s:2:"ip";s:14:"67.212.189.138";s:4:"port";s:5:"11238";s:8:"num_conn";s:1:"2";s:7:"c_state";s:1:"2";s:8:"last_upd";s:19:"2009-06-11 03:07:21";s:8:"location";s:3:"USA";}i:408;a:38:{s:9:"server_id";s:3:"408";s:7:"session";s:32:"1a8489e7f8c9c7ec344cdb2a10c9f233";s:5:"mname";s:23:"TurooX\'s Game Come all!";s:5:"class";s:1:"1";s:7:"private";s:1:"0";s:2:"nm";s:1:"1";s:2:"sd";s:1:"0";s:2:"rd";s:1:"0";s:2:"dm";s:1:"0";s:6:"league";s:1:"0";s:11:"max_players";s:1:"5";s:4:"tier";s:1:"1";s:8:"priv_key";s:0:"";s:9:"no_repick";s:1:"0";s:6:"no_agi";s:1:"0";s:7:"drp_itm";s:1:"0";s:8:"no_timer";s:1:"0";s:6:"rev_hs";s:1:"0";s:7:"no_swap";s:1:"0";s:6:"no_int";s:1:"0";s:8:"alt_pick";s:1:"0";s:4:"veto";s:1:"0";s:4:"shuf";s:1:"0";s:6:"no_str";s:1:"0";s:7:"no_pups";s:1:"0";s:5:"dup_h";s:1:"0";s:2:"ap";s:1:"1";s:2:"ar";s:1:"0";s:2:"em";s:1:"0";s:2:"rs";s:1:"0";s:2:"nl";s:1:"1";s:6:"officl";s:1:"1";s:2:"ip";s:13:"94.229.64.198";s:4:"port";s:5:"11238";s:8:"num_conn";s:1:"1";s:7:"c_state";s:1:"2";s:8:"last_upd";s:19:"2009-06-11 05:29:48";s:8:"location";s:3:"USA";}}}'
