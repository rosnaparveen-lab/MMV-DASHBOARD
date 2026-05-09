class DownloadLimit
  def self.can_download?(user)
    return [false, "Please log in."] unless user

    today = Date.current
    count = DownloadLog.where(user_id: user.id, created_at: today.beginning_of_day..today.end_of_day).count

    current_hour = Time.current.hour
    in_business_hours = current_hour >= 9 && current_hour < 18

    if count >= 2
      return [false, "You have reached the daily limit of 2 downloads."]
    elsif !in_business_hours
      return [false, "Downloads are only allowed between 9:00 AM and 6:00 PM."]
    else
      return [true, nil]
    end
  end
end
