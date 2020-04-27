class Representation::ItemRepresenter
  attr_reader :model_object

  def initialize(model_object)
    @model_object = model_object
  end

  def to_h
    model_object.attributes
  end

  def to_json
    to_h.to_json
  end
end