ActiveAdmin.register Blog do
  form do |f|
    f.inputs "Info" do
      f.input :title
    end
    unless f.object.new_record?
      f.inputs "Slug" do 
        f.input :permalink
      end
    end
    f.inputs "Content" do
      f.input :body, as: :ckeditor, input_html: { ckeditor: {height: 400} }, label: false
    end
    f.actions
  end
end
