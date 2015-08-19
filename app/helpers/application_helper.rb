module ApplicationHelper
  def markdown_to_html(markdown)
<<<<<<< HEAD
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render markdown).html_safe
=======
   renderer = Redcarpet::Render::HTML.new
   extensions = {fenced_code_blocks: true}
   redcarpet = Redcarpet::Markdown.new(renderer, extensions)
   (redcarpet.render markdown).html_safe
>>>>>>> collaborators
  end
end
