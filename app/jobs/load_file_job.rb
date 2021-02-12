class LoadFileJob < ApplicationJob
  queue_as :default

  def perform(document, current_user)
    active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
    url = active_storage_disk_service.send(:path_for, document.file.blob.key)

    document.update_attributes(status: "Processing")
    contacts_loaded, errors, msg, failed = Contacts::CreateContactFromCSV.new(url, current_user.id).process
    document.update_attributes(status: "Success") if contacts_loaded >= 1
    document.update_attributes(status: "Failed") if failed
  end
end
