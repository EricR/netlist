require 'rubygems'
require 'subexec'
require 'open-uri'
require 'json'

target_org = ARGV[0]

puts "[!] Starting NetList script..."

orgs = {}
org_search_results = Subexec.run("curl -s -H \"Accept: application/json\" \"http://whois.arin.net/rest/orgs;name=#{target_org}*\"").output
begin
  org_search_results = JSON.parse(org_search_results)
  results = org_search_results["orgs"]["orgRef"]
  results = [results] if results.kind_of? Hash
  results.each do |org|
	orgs[org["@handle"]] = {:name => org["@name"] }
  end
rescue
  ""
end

puts "[!] Found #{orgs.count} organizations matching your query, \"#{ARGV[0]}\"."
puts "[!] Starting network lookup queries...\n\n"

orgs.each do |org, info|
  orgs[org][:nets] = {}
  nets_search_results = Subexec.run("curl -s -H \"Accept: application/json\" \"http://whois.arin.net/rest/org/#{org}/nets\"").output
  begin
    nets_search_results = JSON.parse(nets_search_results)
    nets_search_results["nets"]["netRef"] = [nets_search_results["nets"]["netRef"]] if nets_search_results["nets"]["netRef"].class != Array
    nets_search_results["nets"]["netRef"].each do |info|
      orgs[org][:nets][info["@handle"]] = { :start => info["@startAddress"], :end => info["@endAddress"] }
    end
  rescue
    ""
  end
end

orgs.each do |k, v|
  puts "----- #{v[:name]} (#{k}) -----"
  v[:nets].each do |netk, netv|
    puts "\n* #{netk}\n  #{netv[:start]} - #{netv[:end]}\n"
  end
  puts "\n"
end

puts "[!] Done. Enjoy!"

