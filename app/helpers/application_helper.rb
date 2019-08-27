module ApplicationHelper
  def tab_active?(tab_name, initial_tab: false)
    # params[:tab]、tab_name、initial_tabの組み合わせによって、
    # どのタブをアクティブにするかを決める。
    # 初期表示でアクティブにするタブは、initial_tabでtrueを指定する。
    if initial_tab && params[:tab].nil?
      'nav-link active'
    elsif tab_name == params[:tab]
      'nav-link active'
    else
      'nav-link'
    end
  end
end
