class LoadFileJob < ApplicationJob
  queue_as :default

  def perform(document, current_user)
    active_storage_disk_service = ActiveStorage::Service::DiskService.new(root: Rails.root.to_s + '/storage/')
    url = active_storage_disk_service.send(:path_for, document.file.blob.key)

    document.update_attributes(status: "Processing")
    success = Contacts::CreateContactFromCSV.new(url, current_user).process
    status = success ? "Success" : "Failed"
    document.update_attributes(status: status)
  end

end
