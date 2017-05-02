class InstallTrigram < ActiveRecord::Migration[5.0]
  def self.up
    ActiveRecord::Base.connection.execute("SELECT set_limit(0.1);")
    ActiveRecord::Base.connection.execute("CREATE EXTENSION IF NOT EXISTS pg_trgm;")
  end

  def self.down
    ActiveRecord::Base.connection.execute("SELECT set_limit(0.1);")
    ActiveRecord::Base.connection.execute("DROP EXTENSION pg_trgm;")
  end
end
