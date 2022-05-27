# frozen_string_literal: true

Rack::Attack.enabled = ENV.fetch("ENABLE_RACK_ATTACK") { Rails.env.production? }
if ENV["REDIS_FOR_RACK_ATTACK_URL"]
  Rack::Attack.cache_store = Redis.new(url: ENV["REDIS_FOR_RACK_ATTACK_URL"])
else
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
end

# Block excessive login attempts
# After 10 requests in 1 minute, block all requests from that IP for 1 hour.
Rack::Attack.blocklist("allow2ban login scrapers") do |req|
  Rack::Attack::Allow2Ban.filter(req.ip, maxretry: 10, findtime: 1.minute, bantime: 1.hour) do
    req.path == "/login" && req.post?
  end
end

# Block suspicious requests for '/etc/password' or wordpress specific paths.
# After 3 blocked requests in 10 minutes, block all requests from that IP for 5 minutes.
Rack::Attack.blocklist("fail2ban pentesters") do |req|
  Rack::Attack::Fail2Ban.filter("pentesters-#{req.ip}", maxretry: 3, findtime: 10.minutes, bantime: 30.minutes) do
    CGI.unescape(req.query_string).include?("/etc/passwd") ||
      req.path.include?("/etc/passwd") ||
      req.path.include?("wp-admin") ||
      req.path.include?("wp-login")
  end
end

# Throttle requests in admin area to 100 requests per minute.
Rack::Attack.throttle("req/ip/admin", limit: 100, period: 1.minute) do |req|
  req.ip if req.path.start_with?("/admin")
end

Rack::Attack.blocklisted_responder = lambda do |_request|
  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 403 for blocklists by default
  [503, {}, ["Blocked"]]
end

Rack::Attack.throttled_responder = lambda do |_request|
  # NB: you have access to the name and other data about the matched throttle
  #  request.env['rack.attack.matched'],
  #  request.env['rack.attack.match_type'],
  #  request.env['rack.attack.match_data'],
  #  request.env['rack.attack.match_discriminator']

  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 429 for throttling by default
  [503, {}, ["Server Error\n"]]
end

ActiveSupport::Notifications.subscribe(/rack_attack/) do |_name, _start, _finish, request_id, payload|
  req = payload[:request]
  Rails.logger.info "[Rack Attack (#{request_id} #{req.ip})] #{req.path} #{req.params}"
end
