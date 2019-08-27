require 'rails_helper'

RSpec.describe ApplicationHelper do
  include ApplicationHelper
  describe 'tab_active?メソッドのテスト' do
    shared_examples_for 'アクティブと判断されること' do
      it { expect(@result).to eq('nav-link active') }
    end

    shared_examples_for 'アクティブと判断されないこと' do
      it { expect(@result).to eq('nav-link') }
    end

    describe 'params[:tab]がnilのとき' do
      before do
        params[:tab] = nil
      end

      context 'initial_tabがtureのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: true)
        end

        it_behaves_like 'アクティブと判断されること'
      end

      context 'initial_tabがfalseのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: false)
        end

        it_behaves_like 'アクティブと判断されないこと'
      end
    end

    describe 'params[:tab]とtab_nameが一致するとき' do
      before do
        params[:tab] = 'tabA'
      end

      context 'initial_tabがtureのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: true)
        end

        it_behaves_like 'アクティブと判断されること'
      end

      context 'initial_tabがfalseのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: false)
        end

        it_behaves_like 'アクティブと判断されること'
      end
    end

    describe 'params[:tab]とtab_nameが一致しないとき' do
      before do
        params[:tab] = 'tabB'
      end

      context 'initial_tabがtureのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: true)
        end

        it_behaves_like 'アクティブと判断されないこと'
      end

      context 'initial_tabがfalseのとき' do
        before do
          @result = tab_active?('tabA', initial_tab: false)
        end

        it_behaves_like 'アクティブと判断されないこと'
      end
    end
  end
end
