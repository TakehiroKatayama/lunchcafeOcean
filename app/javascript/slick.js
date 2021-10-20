$(document).on('turbolinks:load', function () {
  $(function () {
    $('.slider').slick({
      autoplay: true,
      autoplaySpeed: 4000,
      slidesToShow: 4,
      slidesToScroll: 1,
      swipeToSlide: true,
      dots: true,
      prevArrow: '<h2 class="slide-arrow prev-arrow text-muted"><i class="fas fa-chevron-left"></i></i></h2>',
      nextArrow: '<h2 class="slide-arrow next-arrow text-muted"><i class="fas fa-chevron-right"></i></h2>',

      responsive: [
        {
          breakpoint: 1140,
          settings: {
            slidesToShow: 3,
          },
        },
        {
          breakpoint: 992,
          settings: {
            slidesToShow: 2,
            prevArrow: false,
            nextArrow: false,
          },
        },
      ],
    });
  });
});
