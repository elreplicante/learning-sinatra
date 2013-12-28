Given(/^the system knows about the following songs:$/) do |songs|
  App.data = songs.hashes
end