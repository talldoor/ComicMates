module ApplicationHelper
  def tab_active?(tab_name, initial_tab: false)
    # 初期表示では基準タブ（initial_tab）をアクティブにする
    if initial_tab && params[:tab].nil?
      'nav-link active'
    elsif tab_name == params[:tab]
      'nav-link active'
    else
      'nav-link'
    end
  end
end
