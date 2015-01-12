class UserNotifierPreview < ActionMailer::Preview
  def weekly_report_empty
    UserNotifier.weekly_report(User.new)
  end

  def weekly_report_full
    UserNotifier.weekly_report(elia)
  end

  # …s
end
