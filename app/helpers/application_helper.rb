module ApplicationHelper
  def default_meta_tags
    {
      site: 'LockAway',
      title: 'LockAway',
      reverse: true,
      charset: 'utf-8',
      description: '悪い習慣をロックして良い習慣をアンロックすることをサポート',
      keywords: '習慣,習慣管理',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('ogp.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        # site: '@lockaway', # アプリの公式Twitterアカウントがあれば、アカウント名を書く
        image: image_url('ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end

  def share_message(habit_name, reward_name)
    message = "習慣［#{habit_name}］が 報酬［#{reward_name}］を達成しました！\n#LockAway\n"
    URI.encode_www_form_component(message)
  end

  def determine_back_path
    if request.referer&.include?(public_habits_path)
      public_habits_path
    elsif request.referer&.include?(habits_path)
      habits_path
    else
      habits_path
    end
  end

  def flash_css_class(message_type)
    case message_type.to_sym
    when :success then "alert-success"
    when :error   then "alert-error"
    when :warning then "alert-warning"
    when :info    then "alert-info"
    else "alert"
    end
  end

  def flash_icon(message_type)
    case message_type.to_sym
    when :success
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>'.html_safe
    when :error
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>'.html_safe
    when :warning
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" /></svg>'.html_safe
    when :info
      '<svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 shrink-0 stroke-current" fill="none" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>'.html_safe
    else
      ""
    end
  end

  def google_client_id
    ENV['GOOGLE_CLIENT_ID']
  end

  def google_callback_url
    ENV['GOOGLE_CALLBACK_URL']
  end
end
