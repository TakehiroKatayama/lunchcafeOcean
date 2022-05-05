class ReservationsController < ApplicationController
  def index
    @reservation = Reservation.new
  end

  def confirm
    capacity_id = Capacity.find_by(start_time: params[:reservation][:capacity_id]).id  # 選択された日付に紐づくcapacity_idを呼び出す
    @reservation = Reservation.new(reservation_params.merge(capacity_id: capacity_id)) # 選択された日付に紐づいたcapacity_idを挿入し予約を作成
    return unless @reservation.invalid?                                                # バリデーションに引っかかった場合のレンダリング

    flash.now[:danger] = "ご選択頂いたご来店日は#{@reservation.capacity.capacity_status_i18n}です。"
    notifier = Slack::Notifier.new(
      Rails.application.credentials.slack[:notifier],
      channel: '#エラー',
      username: '予約失敗通知くん'
    )
    notifier.ping('予約に失敗しました')
    render :index
  end

  def back
    @reservation = Reservation.new(reservation_params) # 入力した値を保持したままフォームへ戻る
    render :index
  end

  def create
    Reservation.transaction do
      @reservation = Reservation.create!(reservation_params)
      @reservation.change_capacity                           # 予約日に紐づくcapacityから予約人数をマイナスする
      @reservation.full?                                     # 席数が0になった場合にcapacityステータスを満席に変更する。
      ReservationMailer.email(@reservation).deliver_now      # 入力されたメールアドレスに確認メールを送信
      view_context.reservation_to_slack                      # 予約の登録をSlackへ通知
    end
    redirect_to root_path, success: 'ご予約が完了しました。'
  rescue StandardError
    redirect_to reservations_path, danger: 'ご予約ができませんでした。店舗までご連絡下さい。'
  end

  private

  def reservation_params
    params.require(:reservation).permit(:name, :email, :phonenumber, :number_of_people, :visiting_time, :reservation_status, :user_id, :capacity_id)
  end
end
