class BlogsController < InheritedResources::Base

  def index
    @blogs = Blog.limit(12)
    @videos = Video.select([:id,:title,:permalink,:created_at,:thumb]).limit(4).order("random()")
  end

  def show
    @blog = Blog.find(params[:id])
    @blogs = Blog.select([:created_at,:id,:title,:permalink]).limit(12)
    @videos = Video.select([:id,:title,:permalink,:created_at,:thumb]).limit(4).order("random()")
  end

end
