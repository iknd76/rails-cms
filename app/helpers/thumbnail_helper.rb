# frozen_string_literal: true

module ThumbnailHelper
  def sortable_thumbnails_for(record)
    images = record.images.includes(:record, :blob).order(:position).load
    return content_tag :span, "No attached images found.", class: "text-neutral-500 italic" if images.empty?

    content_tag :div, data: { controller: "sortable", sortable_url_value: admin_sortables_path } do
      content_tag :ul, class: "flex flex-wrap gap-4", data: { sortable_target: "list" } do
        safe_join(images.map { |image| thumbnail_for(image) })
      end
    end
  end

  def thumbnail_for(image)
    content_tag :li, data: { sgid: image.to_sgid_param } do
      image_tag image.variant(:thumb), class: "object-cover h-16 w-24 rounded-md cursor-move"
    end
  end
end
