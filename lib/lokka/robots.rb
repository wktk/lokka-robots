module Lokka
  module Robots
    def self.registered(app)
      app.after do
        tag = Option.x_robots_tag || ''
        unless tag.empty?
          response.headers['X-Robots-Tag'] = tag
        end
      end

      app.get '/admin/plugins/robots' do
        login_required
        @x_robots_tag = Option.x_robots_tag
        haml :'plugin/lokka-robots/views/index', layout: :'admin/layout'
      end

      app.put '/admin/plugins/robots' do
        login_required
        Option.x_robots_tag = params[:x_robots_tag]
        redirect(to('/admin/plugins/robots'))
      end
    end
  end
end
