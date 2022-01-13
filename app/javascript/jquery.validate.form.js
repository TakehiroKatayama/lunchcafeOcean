$(document).on('turbolinks:load', function () {
  $(function () {
    var methods = {
      password: function (value, element) {
        return this.optional(element) || /^(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}$/i.test(value);
      },
    };
    $.each(methods, function (key) {
      $.validator.addMethod(key, this);
    });
    $('#contact_form').validate({
      errorElement: 'span',
      rules: {
        'contact[name]': {
          required: true,
          maxlength: 20,
        },
        'contact[email]': {
          required: true,
          email: true,
          maxlength: 256,
        },
        'contact[phonenumber]': {
          required: true,
          rangelength: [10, 11],
          number: true,
        },
        'contact[category]': {
          required: true,
        },
        'contact[message]': {
          required: true,
          maxlength: 2000,
        },
      },
      messages: {
        'contact[name]': {
          required: 'お名前を入力して下さい',
          maxlength: '20文字以内で入力して下さい',
        },
        'contact[email]': {
          required: 'メールアドレスを入力して下さい',
          email: 'メールアドレスの形式で入力して下さい',
          maxlength: '256文字以内で入力して下さい',
        },
        'contact[phonenumber]': {
          required: '半角数字で入力して下さい',
          rangelength: '10〜11文字で入力して下さい',
          number: 'ハイフンなしで入力して下さい',
        },
        'contact[category]': {
          required: 'カテゴリーを選択して下さい',
        },
        'contact[message]': {
          required: 'メッセージを入力して下さい',
          maxlength: '2000文字以内で入力して下さい',
        },
      },
    });
    $('#reservation_form').validate({
      errorElement: 'span',
      rules: {
        'reservation[name]': {
          required: true,
          maxlength: 20,
        },
        'reservation[email]': {
          required: true,
          email: true,
          maxlength: 256,
        },
        'reservation[phonenumber]': {
          required: true,
          rangelength: [10, 11],
          number: true,
        },
        'reservation[capacity_id]': {
          required: true,
        },
        'reservation[visiting_time]': {
          required: true,
        },
        'reservation[number_of_people]': {
          required: true,
        },
      },
      messages: {
        'reservation[name]': {
          required: 'お名前を入力してください',
          maxlength: '20文字以内で入力してください',
        },
        'reservation[email]': {
          required: 'メールアドレスを入力して下さい',
          email: 'メールアドレスの形式で入力してください',
          maxlength: '256文字以内で入力してください',
        },
        'reservation[phonenumber]': {
          required: '電話番号を半角数字で入力して下さい',
          rangelength: '10〜11文字で入力してください',
          number: 'ハイフンなしで入力して下さい',
        },
        'reservation[capacity_id]': {
          required: '日付を選択して下さい',
        },
        'reservation[visiting_time]': {
          required: '来店時間を選択して下さい',
        },
        'reservation[number_of_people]': {
          required: '人数を選択して下さい',
        },
      },
    });
    $('#user_form').validate({
      errorElement: 'span',
      rules: {
        'user[name]': {
          required: true,
          maxlength: 20,
        },
        'user[email]': {
          required: true,
          email: true,
          maxlength: 256,
        },
        'user[phonenumber]': {
          required: true,
          rangelength: [10, 11],
          number: true,
        },
        'user[password]': {
          required: true,
          password: true,
        },
        'user[password_confirmation]': {
          required: true,
          password: true,
          equalTo: '#user_password',
        },
      },
      messages: {
        'user[name]': {
          required: 'お名前を入力してください',
          maxlength: '20文字以内で入力してください',
        },
        'user[email]': {
          required: 'メールアドレスを入力して下さい',
          email: 'メールアドレスの形式で入力してください',
          maxlength: '256文字以内で入力してください',
        },
        'user[phonenumber]': {
          required: '電話番号を半角数字で入力して下さい',
          rangelength: '10〜11文字で入力してください',
          number: 'ハイフンなしで入力して下さい',
        },
        'user[password]': {
          required: 'パスワードを入力してください',
          password: 'パスワードは半角英字・数字を混ぜて8文字以上36文字以内にしてください',
        },
        'user[password_confirmation]': {
          required: '確認用パスワードを入力してください',
          password: '英字と数字両方を含むパスワードを入力してください',
          equalTo: 'パスワードが一致していません',
        },
      },
    });
  });
});
