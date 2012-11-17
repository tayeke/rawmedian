ActiveAdmin.register Video do 

  form do |f|
    f.inputs "Video Details" do
      f.input :title
      f.input :permalink
      f.input :vimeo_id, :label => 'Vimeo Id' #, :input_html => {:readonly => true}
      f.input :tags,
              :as => :select, 
              :multiple => true, 
              :collection => Tag.all,
              :selected => f.object.tags.map(&:id),
              :input_html => {'data-placeholder' => "Begin Typing a Tag...", 'class' => 'chzn-select'}
      f.input :description
    end
    f.buttons
  end

end                                   
