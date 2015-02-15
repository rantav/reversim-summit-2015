Template.layoutMobile.events
  'touchstart #sideMenuBtn': (event, context)->
    if context.$('#sideMenuBtn').hasClass('fa-arrow-left')
      LayoutManager.hideNav()
    else
      LayoutManager.showNav()


  'touchstart #overlay': (event, context) ->
    if context.$('#sideMenuBtn').hasClass('fa-arrow-left')
      LayoutManager.hideNav()


@LayoutManager = {}
@LayoutManager.showNav = () ->
  $('#sideMenu').removeClass('hideToLeft').addClass('showFromLeft')
  $('#overlay').transition({'opacity': 0.5})
  $('#overlay').removeClass('pointer-none')
  $('#sideMenuBtn').removeClass().addClass('fa fa-arrow-left sideMenuBtn')

@LayoutManager.hideNav = () ->
  $('#sideMenu').removeClass('showFromLeft').addClass('hideToLeft')
  $('#overlay').transition({'opacity': 0})
  $('#overlay').addClass('pointer-none');
  $('#sideMenuBtn').removeClass().addClass('fa fa-bars sideMenuBtn')