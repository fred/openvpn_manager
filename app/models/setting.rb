class Setting < ActiveRecord::Base
  validates_presence_of :var
  validates_uniqueness_of :var
  validates_length_of :var, :within => 2..40
  
  def self.get(var)
    var = var.to_s
    setting = self.find(:first, :select => "value", :conditions => ["var = ?", var])
    if setting
      return setting.value
    else
      return ""
    end
  end
  
end
