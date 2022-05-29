# frozen_string_literal: true

# config/initializers/active_storage_attachment.rb

module ActiveStorageAttachmentList
  extend ActiveSupport::Concern

  included do
    acts_as_list scope: %i[record_type record_id]
  end
end

Rails.configuration.to_prepare do
  ActiveStorage::Attachment.include ActiveStorageAttachmentList
end
