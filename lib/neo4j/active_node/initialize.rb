module Neo4j::ActiveNode::Initialize
  extend ActiveSupport::Concern
  include Neo4j::Shared::Initialize

  attr_reader :called_by

  # called when loading the node from the database
  # @param [Neo4j::Node] persisted_node the node this class wraps
  # @param [Hash] properties of the persisted node.
  def init_on_load(persisted_node, properties)
    self.class.extract_association_attributes!(properties)
    @_persisted_obj = persisted_node
    changed_attributes && changed_attributes.clear
    @attributes = convert_and_assign_attributes(properties)
  end

  def module_init(id, properties, labels)
    @neo_id = id
    @labels = labels.map!(&:to_sym)
    self.class.extract_association_attributes!(properties)
    @_persisted_obj = self
    changed_attributes && changed_attributes.clear
    @attributes = convert_and_assign_attributes(properties)
    self
  end
end
