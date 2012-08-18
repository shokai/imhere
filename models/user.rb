
class User
  include Mongoid::Document
  field :id, :type => Integer
  field :created_at, :type => Time , :default => lambda{Time.now}
  field :updated_at, :type => Time , :default => lambda{Time.now}
  field :token, :type => String
  field :twitter, :type => Hash, :default => Hash.new
  field :name, :type => String
  field :icon_url, :type => String
  field :loc, :type => Hash, :default => {'lat' => 0, 'lon' => 0}

  validates_uniqueness_of :id
  validates_format_of :name, :with => /^[a-zA-Z0-9_]+$/
  validates_uniqueness_of :name
  validates_format_of :icon_url, :with => /^https?:\/\/.+$/
  validates_uniqueness_of :token
  before_save :update_updated_at
  before_update :update_updated_at

  :protected
  def update_updated_at
    self.updated_at = Time.now
  end

  :public
  def to_json(*a)
    {
      :name => self.name,
      :loc => self.loc,
      :updated_at => self.updated_at,
      :created_at => self.created_at
    }.to_json(*a)
  end

  def self.find_by_id(id)
    self.where(:id => id).limit(1).first
  end

  def self.find_or_create_by_id(id)
    self.find_or_create_by(:id => id)
  end

  def self.find_by_token(token)
    self.where(:token => token).limit(1).first
  end

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
