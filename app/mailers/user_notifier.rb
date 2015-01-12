# app/mailers/user_notifier

class UserNotifier < ActionMailer::Base
  default from: 'weekly-report@timesampler.com', reply_to: 'elia+timesampler-weekly-report@schito.me'
  # helper DayHelper

  def weekly_report user
    @user         = user
    @project_days = project_days
    @days         = project_days.group_by(&:day).to_a.sort
    @end_time     = end_time
    @start_time   = start_time

    mail to: user.email, subject: "TimeSampler: Weekly activity report · week #{start_time.cweek}"
  end
end