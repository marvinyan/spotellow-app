class Event < ApplicationRecord
    validates :description, :start_time, :end_time, presence: true
    validate :end_time_cannot_be_before_start_time
    validate :start_time_and_end_time_must_be_same_day

    def end_time_cannot_be_before_start_time
        if valid_times? && end_time < start_time
            errors.add(:end_time, "must be after start time")
        end
    end

    def start_time_and_end_time_must_be_same_day
        if valid_times? && start_time.beginning_of_day != end_time.beginning_of_day
            errors.add(:end_time, "must occur on the same day as the start time")
        end
    end

    # Rails runs through ALL validations, even if the first one fails
    # When times are missing, only display "can't be blank" messages
    def valid_times?
        return !start_time.nil? && !end_time.nil?
    end
end
