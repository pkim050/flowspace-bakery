class Cookie < ActiveRecord::Base
  belongs_to :storage, polymorphic: :true
  
  validates :storage, presence: true

  def ready?
    #binding.pry
    return true if self.status == "ready"
    return false
  end
end
