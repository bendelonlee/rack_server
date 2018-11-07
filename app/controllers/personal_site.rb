require "rack"

class PersonalSite
  def self.call(env)
    ['200', {'Content-Type' => 'text/html'}, [File.open('./app/views/index.html')]]
  end
end
