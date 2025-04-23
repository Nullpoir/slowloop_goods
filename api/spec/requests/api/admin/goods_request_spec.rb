require 'rails_helper'

RSpec.describe "Api::Admin::Goods", type: :request do
  let!(:login_user) { create :user, is_admin: true }
  let(:result) { JSON.parse(response.body) }
  let(:headers) { { 'Content-Type' => 'application/json' } }
  let(:not_logged_in_headers) { { 'Host' => 'example.com', 'Content-Type' => 'application/json' } }
  let(:user_logged_in_headers) { not_logged_in_headers.merge(user_token) }
  let(:invalid_user_logged_in_headers) { not_logged_in_headers.merge(invalid_user_token) }
  let(:user_token) { login_user.create_new_auth_token }

  describe '#index' do
    subject { get api_admin_goods_path, params: params, headers: request_headers }

    let!(:params) do
      {
        limit: nil,
        offset: nil,
        order_by: nil,
        direction: nil
      }
    end
    context '正常系' do
      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データ10件ある場合に' do
          let!(:created_number) { 10 }
          let!(:goods) { create_list :good, created_number}
          it 'データを全件返すこと' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
          end

          context 'ソートをする場合に' do
            it 'id descでソートできること' do
              params[:q] = {
                s: 'id desc'
              }
  
              subject
    
              is_expected.to eq 200
              expect(result["goods"].size).to eq created_number
              expect(result["goods"].pluck('id')).to eq Good.order(id: :desc).pluck(:id)
            end
          end

          context '検索する場合に' do
            let!(:search_value) { goods.third.name }
            it '検索できること' do
              params[:"q[name_cont]"] = search_value

              is_expected.to eq 200
              expect(result["goods"].size).to eq Good.where('name LIKE ?', "%#{search_value}%").size
            end
          end
        end
      end
      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }
        let!(:created_number) { 10 }
        let!(:goods) { create_list :good, created_number}

        it '401になること' do
          subject

          is_expected.to eq 401
          expect(result["errors"].size).not_to eq nil
        end
      end
    end
    context '異常系' do
      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データ0件ある場合に' do
          let!(:created_number) { 0 }
          let!(:goods) { create_list :good, created_number}
          it 'データを0件返すこと' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
          end
        end
        context 'ソートをする場合に' do
          let!(:created_number) { 10 }
          let!(:goods) { create_list :good, created_number }
          it '値がブランクの場合はid ascでソートされること' do
            subject
  
            is_expected.to eq 200
            expect(result["goods"].size).to eq created_number
            expect(result["goods"].pluck('id')).to eq Good.order(id: :asc).pluck(:id)
          end
        end
      end
    end
  end

  describe '#show' do
    subject { get api_admin_good_path(id: id), headers: request_headers }

    context '正常系' do
      let!(:goods) { create_list :good, 10}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}

          it '指定のデータが返ってくること' do
            subject

            is_expected.to eq 200
            expect(result["good"]["id"]).to eq id
            expect(result["good"]["name"]).to eq goods.third.name
          end
        end
      end

      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}

          it '401が返ってくること' do
            subject

            is_expected.to eq 401
            expect(result["errors"]).not_to eq nil
          end
        end
      end
    end
    context '異常系' do
      let!(:good) { create :good}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context '存在しないIDを指定した場合' do
          let!(:id) { good.id + 1}

          it '404が返ってくること' do
            subject

            is_expected.to eq 404
          end
        end
      end
    end
  end

  describe '#create' do
    subject { post api_admin_goods_path, params: params.to_json, headers: request_headers }
    let!(:params) do
      {
        good: values
      }
    end

    context '正常系' do
      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }
        
        context '新規作成をする時に' do
          let!(:values) do
            {
              name: 'テスト',
              description: 'テストテスト',
              isbn: '1111',
              jan: '2222',
              shopping_url: 'https://example.com',
              released_at: Time.zone.yesterday,
              production_ended_at: Time.zone.tomorrow
            }
          end
          it '作成できること' do
            subject

            is_expected.to eq 200
            expect(result['good']['name']).to eq values[:name]
            expect(result['good']['description']).to eq values[:description]
            expect(result['good']['isbn']).to eq values[:isbn]
            expect(result['good']['jan']).to eq values[:jan]
            expect(result['good']['shoppingUrl']).to eq values[:shopping_url]
          end
        end
      end
      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }
        
        context '新規作成をする時に' do
          let!(:values) do
            {
              name: 'テスト',
              description: 'テストテスト',
              isbn: '1111',
              jan: '2222',
              shopping_url: 'https://example.com',
              released_at: Time.zone.yesterday,
              production_ended_at: Time.zone.tomorrow
            }
          end
          it '作成できないこと' do
            subject

            is_expected.to eq 401
          end
        end
      end
    end
  end

  describe '#update' do
    subject { put api_admin_good_path(id: id), params: params.to_json, headers: request_headers }
    let!(:params) do
      {
        good: values
      }
    end

    context '正常系' do
      let!(:goods) { create_list :good, 10}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}
          let!(:values) do
            {
              name: 'テスト',
              description: 'テストテスト',
              isbn: '1111',
              jan: '2222',
              shopping_url: 'https://example.com',
              released_at: Time.zone.yesterday,
              production_ended_at: Time.zone.tomorrow
            }
          end

          it '更新できること' do
            subject

            is_expected.to eq 200
            expect(result['good']['name']).to eq values[:name]
            expect(result['good']['description']).to eq values[:description]
            expect(result['good']['isbn']).to eq values[:isbn]
            expect(result['good']['jan']).to eq values[:jan]
            expect(result['good']['shoppingUrl']).to eq values[:shopping_url]
          end
        end
      end

      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }
        let!(:values) do
          {
            name: 'テスト',
            description: 'テストテスト',
            isbn: '1111',
            jan: '2222',
            shopping_url: 'https://example.com',
            released_at: Time.zone.yesterday,
            production_ended_at: Time.zone.tomorrow
          }
        end

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}

          it '401が返ってくること' do
            subject

            is_expected.to eq 401
            expect(result["errors"]).not_to eq nil
          end
        end
      end
    end
    context '異常系' do
      let!(:good) { create :good}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context '存在しないIDを指定した場合' do
          let!(:id) { good.id + 1}
          let!(:values) do
            {
              name: 'テスト',
              description: 'テストテスト',
              isbn: '1111',
              jan: '2222',
              shopping_url: 'https://example.com',
              released_at: Time.zone.yesterday,
              production_ended_at: Time.zone.tomorrow
            }
          end

          it '404が返ってくること' do
            subject

            is_expected.to eq 404
          end
        end
      end
    end
  end

  describe '#delete' do
    subject { delete api_admin_good_path(id: id), headers: request_headers }

    context '正常系' do
      let!(:goods) { create_list :good, 10}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}

          it '指定のデータが削除されること' do
            subject

            is_expected.to eq 200
            expect(Good.find_by(id: id)).to eq nil
          end
        end
      end

      context 'ログインしていない時' do
        let!(:request_headers) { not_logged_in_headers }

        context 'データを指定した場合' do
          let!(:id) { goods.third.id}

          it '401が返ってくること' do
            subject

            is_expected.to eq 401
            expect(result["errors"]).not_to eq nil
            expect(Good.find_by(id: id)).not_to eq nil
          end
        end
      end
    end
    context '異常系' do
      let!(:good) { create :good}

      context 'ログインしている時' do
        let!(:request_headers) { user_logged_in_headers }

        context '存在しないIDを指定した場合' do
          let!(:id) { good.id + 1}

          it '404が返ってくること' do
            subject

            is_expected.to eq 404
            expect(Good.find_by(id: good.id)).not_to eq nil
          end
        end
      end
    end
  end
end
