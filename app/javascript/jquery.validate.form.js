$(document).on('turbolinks:load', function () {
  $(function () {
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
  });
});
