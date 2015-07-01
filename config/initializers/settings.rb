if ActiveRecord::Base.connection.table_exists? 'settings'
  Setting.save_default(:sign_up, true)
  Setting.save_default(:submit_entry, false)
end