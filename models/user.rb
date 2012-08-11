
class User
  include Mongoid::Document
  field :created_at, :type => Time , :default => lambda{Time.now}
  field :updated_at, :type => Time , :default => lambda{Time.now}
  field :name, :type => String
  validates_format_of :name, :with => /^[a-zA-Z0-9_]+$/
  validates_uniqueness_of :name
  field :loc, :type => Hash, :default => {'lat' => 0, 'lon' => 0}
  before_save :update_updated_at
  before_update :update_updated_at

  :protected
  def update_updated_at
    self.updated_at = Time.now
  end

  :public
  def self.find_by_name(name)
    self.where(:name => name).limit(1).first
  end

  def self.find_or_create_by_name(name)
    self.find_or_create_by(:name => name)
  end

  def delete_location
    self.loc = {:lat => nil, :lon => nil}
    self
  end
end
