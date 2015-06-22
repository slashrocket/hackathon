if ActiveRecord::Base.connection.table_exists? 'settings'
  Setting.save_default(:sign_up, true)
  Setting.save_default(:submit_entry, false)
  Setting.save_default(:firebase_url, ENV['FIREBASEIO_URL'])
end