require 'rails_helper'

RSpec.describe "Api::V1::Goods", type: :request do
  let(:result) { JSON.parse(response.body) }

  describe '#index' do
    subject { get api_v1_goods_path, params: params }

    let!(:params) do
      {
        limit: nil,
        offset: nil,
        order_by: nil,
        direction: nil
      }
    end
    context '正常系' do
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
    context '異常系' do
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

  describe '#show' do
    subject { get api_v1_good_path(id: id) }

    context '正常系' do
      let!(:goods) { create_list :good, 10}

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
    context '異常系' do
      let!(:good) { create :good}

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
