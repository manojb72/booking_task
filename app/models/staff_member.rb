class StaffMember
  include ActiveModel::Model
  attr_accessor :start_work_hour__c,:start_work_hour_weekend
  attr_accessor :end_work_hour__c,:end_work_hour_weekend
  Hours = Struct.new(:start_work_hour,:end_work_hour,:weekend_start,:weekend_end)
  def initialize(opts)
    hours = Hours.new(opts[:start_work_hour],opts[:end_work_hour],opts[:weekend_start],opts[:weekend_end])
    @start_work_hour__c = hours.start_work_hour
 	@end_work_hour__c = hours.end_work_hour
    @start_work_hour_weekend = hours.weekend_start
    @end_work_hour_weekend = hours.weekend_end
  end

  def events; {} end
  def timezone; Time.find_zone("PST8PDT") end
  def start_hour; self.try(:start_work_hour__c) || '10:00' end
  def end_hour; self.try(:end_work_hour__c)   || '19:00' end
  def start_hour_offset; ChronicDuration.parse([start_hour, ':00'].join) end
  def end_hour_offset; ChronicDuration.parse([end_hour, ':00'].join) end
  def weekend_start_hour; self.try(:start_work_hour_weekend) || '10:00' end
  def weekend_end_hour; self.try(:end_work_hour_weekend)   || '19:00' end

end
