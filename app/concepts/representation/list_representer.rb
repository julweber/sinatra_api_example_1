class Representation::ListRepresenter
  def initialize(model_array)
    @represented = model_array.to_a.map do |obj|
      ::Representation::ItemRepresenter.new(obj).to_h
    end
  end

  def to_h
    {
      count: @represented.count,
      items: @represented
    }
  end

  def to_json
    to_h.to_json
  end
end