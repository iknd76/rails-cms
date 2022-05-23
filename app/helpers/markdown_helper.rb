# frozen_string_literal: true

module MarkdownHelper
  MARKDOWN = Redcarpet::Markdown.new(
    Redcarpet::Render::HTML.new(
      no_images: true,
      no_styles: true,
      safe_links_only: true,
      hard_wrap: true,
      link_attributes: { target: "_blank", rel: "noopener noreferrer" }
    ),
    no_intra_emphasis: true,
    autolink: true,
    tables: false,
    superscript: true,
    quote: true,
    highlight: true
  )

  def markdown(text)
    MARKDOWN.render(text).html_safe
  end
end
