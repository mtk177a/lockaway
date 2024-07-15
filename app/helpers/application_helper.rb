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
end
