unless ( File.basename($0) == 'rake')
  Setting.save_default(:sign_up, true)
  Setting.save_default(:submit_entry, false)
  Setting.save_default(:firebase_url, ENV['FIREBASEIO_URL'])
end