ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Vimeo Videos Not On Site" do
          ul do
            videos = Video.vimeo_videos
            flash[:error] = 'Please set the vimeo_account option' and next unless videos
            current_videos = Video.select(:vimeo_id).map(&:vimeo_id)
            videos = (videos.keep_if {|v| !current_videos.include?(v['id'].to_s)} || [])
            videos.each do |video|
              form_for(Video.new, :method => :post, :url => '/admin/videos') {|f| 
                f.hidden_field(:title, :value => video['title']) 
                f.hidden_field(:vimeo_id, :value => video['id']) 
                f.hidden_field(:thumb, :value => video['thumbnail_medium']) 
                f.hidden_field(:preview, :value => video['thumbnail_large']) 
                f.hidden_field(:description, :value => video['description']) 
                f.submit 'Add To Site'
              }
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
