require 'sinatra/base'
require 'launchy'
require 'open-uri'


module InitialText
  def new
    @text = nil
  end

  def self.set(text)
    @text = text
  end

  def self.get
    @text
  end
end


class WebServer
  include InitialText
  def initialize(&block)
    InitialText.set(block.call)
    @app = Rack::Builder.new do
      use SuperApp::App
      run SuperApp::App.new
    end
  end

  def self.call(env)
    @app.call env
  end

  def start
    options = {
      :Host => '127.0.0.1',
      :Port => '4321',
    }
    Launchy.open("http://localhost:#{options[:Port]}")

    Rack::Handler::WEBrick.run @app, :Port => options[:Port]
  end
end


module SuperApp
  class App < Sinatra::Base
    include InitialText

    def initialize(*args)
      super(*args)
    end

    configure do
      set :port, 4321
      set :session_secret, 'super secret'
      enable :sessions
      set :app_initialized, false
    end

    helpers do
      def fetch_resource(uri)
        uri != nil ? open(uri, :redirect => true).read : nil
      end
    end

    get '/' do
      if settings.app_initialized != true
        settings.app_initialized = true
        session.clear
      end
      <<-STRINGSTRINGSTRING
<p>Hi there! This is a web server runnging...</p>
<p><a href="/quit">Quit</a></p>
<p>
<form method="post" action="/">
  <p>
    <label for="shell_command">Shell command:</>
    <input style="width: 80%;" type="text" placeholder="printf \
'This is a shell command.';" name="shell_command" \
value="#{session[:last_shell_command]}"/>
  </p>
  <p>
    <label for="highlight_pattern">Highlight pattern:<label/>
    <input type="text" placeholder="\\bthe\\b" \
name="highlight_pattern"/>
  </p>
  <p>
    <label for="external_uri">EXTERNAL_URI:<label/>
    <input type="text" placeholder="http://example.com" \
name="external_uri"/>
  </p>
  <button type="submit">OK</button>
</form>
</p>
<hr/>
#{fetch_resource session[:external_uri]}
<pre>#{InitialText.get}</pre>
STRINGSTRINGSTRING
    end

    post '/' do
      session[:last_shell_command] = params[:shell_command]
      output = ''
      shell_command_thread = Thread.new do
        output = `bash -c "#{params[:shell_command]}"`
      end
      shell_command_thread.join
      output = output.gsub /#{params[:highlight_pattern]}/, '<strong style="background-color: #FFFF33;">\0</strong>'
        InitialText.set output

      session[:external_uri] = params[:external_uri]
      redirect to('/'), 302
    end

    get '/quit' do
      quit_thread = Thread.new{ Process.kill 'TERM', Process.pid }
      quit_thread.join
      'Bye!'
    end

    get '/hello' do
      'Hello there! How are you?'
    end
  end
end
