require "rack"

class PersonalSite
  def self.call(env)
    path = env["PATH_INFO"]
    case
    when path == '/' then index
    when path == '/about' then about
    when path == '/main.css' then css
    when path[/^\/blogs\/\d+/]
      id = path[/(?<=^\/blogs\/)\d+/]
      blog_nums.include?(id) ? show_blog(id) : error
    else
      error
    end
  end

  def self.show_blog(id)
    self.render_view("blog#{id}.html")
  end

  def self.blog_nums
    views = Dir.entries("./app/views/")
    views.map{|filename| filename[/(?<=^blog)\d+/]}.compact
  end

  def self.index
    self.render_view('index.html', )
  end

  def self.about
    self.render_view('about.html')
  end

  def self.error
    self.render_view('error.html', '404')
  end

  def self.css
    render_static('main.css')
  end

  def self.render_view(page, code = '200')
    [code, {'Content-Type' => 'text/html'}, [File.read("./app/views/#{page}")]]
  end

  def self.render_static(asset)
    [200, {'Content-Type' => 'text/html'}, [File.read("./public/#{asset}")]]
  end
end
