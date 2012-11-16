ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span "Welcome to Active Admin. This is the default dashboard page."
        small "To add dashboard sections, checkout 'app/admin/dashboards.rb'"
      end
    end

    columns do
      column do
        panel "Vimeo Videos" do
          ul do
            videos = Video.vimeo_videos
            flash[:error] = 'Please set the vimeo_account option' and next unless videos
            videos.each do |video|
              li content_tag :p, raw("
                #{video['title']}
                <br />
                #{image_tag(video['thumbnail_medium'])}
              ")
            end
          end
        end
      end
    end

  end # content
end
