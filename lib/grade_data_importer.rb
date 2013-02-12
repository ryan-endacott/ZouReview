
# Takes parsed class data through import_data and builds and saves models with it
class GradeDataImporter

  # Takes parsed class data and builds and saves models with it
  def self.import_data(class_data)
    class_data.each do |section_data|
      handle_section_data section_data
    end
  end


end
