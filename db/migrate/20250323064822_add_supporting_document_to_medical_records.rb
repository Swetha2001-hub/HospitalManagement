class AddSupportingDocumentToMedicalRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :medical_records, :supporting_document, :string
  end
end
