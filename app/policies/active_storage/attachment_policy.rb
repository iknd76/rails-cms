# frozen_string_literal: true

module ActiveStorage
  class AttachmentPolicy < ApplicationPolicy
    def sort?
      update?
    end
  end
end
