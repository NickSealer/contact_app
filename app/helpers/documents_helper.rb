# frozen_string_literal: true

# Helpers for documents
module DocumentsHelper
  def status_color(value)
    statuses = {
      'Success': 'table-success',
      'Failed': 'table-danger',
      'Waiting': 'table-secondary',
      'Processing': 'table-primary'
    }
    statuses[value.to_sym]
  end
end
