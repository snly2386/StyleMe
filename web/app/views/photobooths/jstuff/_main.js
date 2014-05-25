$(document).ready(function(){
  var mijloPostsL = $('.mijlo-posts .post-left'), //posts on left side (for anim)
    mijloPostsR = $('.mijlo-posts .post-right'), // and on right side
    postDetails = $('.post-details'), // post details view
    stickyHeader = false, // is sticky header enabled?
    scrollingBG = false, // is scrolling background enabled?
    bagOpen = false,
    header = $('.head-stick'), //middle header(sticky)
    headerTop = $('.head-top'), //top header
    headerWrap = $('#header-wrap'),
    headerOffset = headerWrap.offset().top,
    mijloSplash = $('.mijlo-splash'),
    mijloSplashS = $('.mijlo-splash-scroll'),
    mijloInfo = $('.mijlo-info'),
    mijloInfoH = mijloInfo.height(),
    mijloPosts = $('.mijlo-posts'),
    mijloBag = $('.mijlo-bag'),
    imageRatio =  1.5, // W/H ratio for post images
    staticHeader = header.hasClass('static');
  
  
  function togglepostDetails(){   
    if(header.has(postDetails).length){
      postDetails.insertAfter(mijloPosts).removeClass('active');
      postDetails.hide();
    }
    else{
      postDetails.show();
      postDetails.appendTo(header).addClass('active');
    }
  }
  function getWindowHeight(){
    return window.innerHeight ? window.innerHeight : $(window).height();
  }
  function setupThumbnails(){
    var mijloPostsL = $('.mijlo-posts .post-left'),
      mijloPostsR = $('.mijlo-posts .post-right');
    //calculate and set image heights, count posts
    var imgH = Math.floor($(window).width() / ($(window).width() < 767 ? 2 : 4) / imageRatio);
    var posts = $('.post').css('height', imgH);
    var i = 0;
    while(i < posts.length / 2){    
      newId = (i%2 === 0) ? 2*i : 2*i-1;
      mijloPostsL.children('.post').eq(i).data({'post-id': newId, 'prev': newId-1, 'next': newId+1}).addClass('post-'+newId);
      mijloPostsR.children('.post').eq(i).data({'post-id': newId+2, 'prev': newId+1, 'next': newId+3}).addClass('post-'+(newId+2));
      if(newId === 0){
        mijloPostsL.children('.post').eq(i).removeData('prev');
      }
      else if(newId+2 == posts.length-1){
        mijloPostsR.children('.post').eq(i).removeData('next');
      }
      i++;
    }
  }
  function setupPostDetails(postId, anim){
    var post = $('.post-'+postId),
      prevPostId = post.data('prev'),
      nextPostId = post.data('next'),
      inner = post.find('.post-inner'), 
      dataImg = inner.data('image'),
      dataName = inner.data('name'),
      dataPosition = inner.data('position'),
      dataCompany = inner.data('company'),
      dataPermalink = siteURL + 'guest/' + inner.data('guest-id') + '/' + dataName,
      dataLink = inner.data('link');

    postDetails.data('post-id', postId);
    
    postDetails.find('.post-name').html(dataName.replace(' ', '<br/>'));
    postDetails.find('.post-title').children('.position').text(dataPosition).end()
                    .children('.company').text(dataCompany).attr('href', dataLink);
    postDetails.find('.post-link-perm').attr('href', dataPermalink);
    
    //lock controls while loading image
    postDetails.find('.prev').data('prev', 'locked');
    postDetails.find('.next').data('next', 'locked');
    postDetails.find('.close').data('close', 'locked');
    
    //remove previous image
    if(!anim){
      postDetails.find('.post-img > img').remove().end()
            .find('.img-loading').css('display', 'block');
    }else{
      postDetails.find('.img-loading').css('display', 'block');
    }
    $('<img>').load(function(){
      var imageW = postDetails.find('.post-img > img').width();
      
      //remove loading spinner
      postDetails.find('.img-loading').css('display', 'none');
      
      if(anim == 'next'){
        postDetails.find('.post-img').append($(this)).animate({'left': -imageW}, 400);
        setTimeout(function(){
          postDetails.find('.post-img').css('left', '0');
          postDetails.find('.post-img > img:first-child').remove();
        }, 500);
      }
      else if(anim == 'prev'){
        postDetails.find('.post-img').css('left', -imageW);
        postDetails.find('.post-img').prepend($(this)).animate({'left': 0});
        setTimeout(function(){
          postDetails.find('.post-img').css('left', '0');
          postDetails.find('.post-img > img:last-child').remove();
        }, 500);
      }
      else{
        postDetails.find('.post-img').append($(this));
      }
      //unlock controls
      setTimeout(function(){
        postDetails.find('.prev').data('prev', prevPostId);
        postDetails.find('.next').data('next', nextPostId);
        postDetails.find('.close').data('close', '');       
      }, 500);
    }).attr({
      // src: siteURL + 'img/fullsize/'+dataImg
      src: dataImg

    }).error(function(){
//unlock controls
postDetails.find('.prev').data('prev', prevPostId);
      postDetails.find('.next').data('next', nextPostId);
      postDetails.find('.close').data('close', '');
    });
  }
  
  $(window).scroll(function(){
        var y = $(window).scrollTop();
    if(!staticHeader){
      //sticky header     
      if(y > headerOffset){
        if(!stickyHeader){
          header.addClass('sticky');
          postDetails.css({'position':'fixed'});
          mijloSplash.hide();
          stickyHeader = true;
        } 
      }
      else if(stickyHeader){
        postDetails.css({'position':'absolute'});
        header.removeClass('sticky');
        mijloSplash.show();
        stickyHeader = false;
      }
    }
    if(!mobile){
      if(y > mijloInfoH){
        if(!scrollingBG){
          mijloSplashS.show();
          mijloSplashS.css({'top': mijloInfoH ,'z-index': '-1'});
          mijloSplash.hide();
          headerTop.css({'top': mijloInfoH, 'position': 'absolute'});
          scrollingBG = true;
        }
      }
      else if(scrollingBG){
        mijloSplash.show();
        mijloSplashS.hide();
        mijloSplashS.css({'z-index': '-2','top': '0px'});
        headerTop.removeAttr('style');
        scrollingBG = false;
      }
    }
  });
  
  $(window).resize(function(){
    var windowW = $(window).width();
    var windowH = getWindowHeight();
    var imgH =  Math.round(windowW / (windowW < 767 ? 2 : 4) / imageRatio);
    $('.mijlo-posts .post').css('height', imgH);
    
    //update header height (header is smaller on mobile)
    headerOffset = headerWrap.offset().top;
    mijloInfoH = mijloInfo.height();
    
    //set height for post details & bag windows
    postDetails.css({'height': (windowH - header.height())});
    mijloBag.css({'height': (windowH - header.height())});
    
    //fire off a scroll event to update sticky header if necessary
    $(window).scroll();
  });
  
  mijloPosts.on('click', '.post', function(){
    //setup post details info
    var postId = $(this).data('post-id');
    setupPostDetails(postId);
    postDetails.show();
    
    //scroll to details area
    var y = $(window).scrollTop();
    var w = $(window).width();
    if(y < headerOffset){
      $.scrollTo(header, 400);
    }
    
    //animate post columns
    $('.post-details .post-left, .post-details .post-right').removeAttr('style');
    $('.mijlo-posts .post-left').animate({'left': -(w / 2)}, 400);
    $('.mijlo-posts .post-right').animate({'right': -(w / 2)}, 400);
    setTimeout(togglepostDetails, 500);
    
    //SEO and NON-JS fallback, prevent links from opening if JS is present
    return false;
  });
  postDetails.on('click', '#close-details', function(){ 
    if($(this).data('close') !== 'locked'){
      var w = $(window).width();
      //animate post details
      $('.mijlo-posts .post-left, .mijlo-posts .post-right').removeAttr('style');
      if($(window).width() <= 767){
        togglepostDetails();
      }
      else{
        $('.post-details .post-left').animate({'left': -(3*w/10)}, 400);
        $('.post-details .post-right').animate({'right': -(7*w/10)}, 400);
        setTimeout(togglepostDetails, 500);
      }
      var postId = postDetails.data('post-id');
      var post = $('.post-'+postId);
      $.scrollTo(post, 400, {offset: -header.height()});
    }
  });
  postDetails.on('click','.prev', function(){
    if($(this).data('prev') !== 'locked'){
      setupPostDetails($(this).data('prev'), 'prev');
    }
  });
  postDetails.on('click','.next', function(){
    if($(this).data('next') !== 'locked'){
      setupPostDetails($(this).data('next'), 'next');
    }
  });
  $('.show-bag').on('click', function(){
    if(!bagOpen){
      $('#bag-slider').cycle({
        fx: 'scrollHorz',
        prev: '#bag-prev',
        next: '#bag-next',
        paused: true
      });
      if($(window).scrollTop() < headerOffset){
        $.scrollTo(header, 400);
      }
      mijloBag.appendTo(header).addClass('active');
      mijloBag.find('.content').animate({'left': '0'}, 500);
      bagOpen = true;
    }
  });
  $('#close-bag').on('click', function(){
    if(bagOpen){
      $('#bag-slider').cycle('destroy');
      mijloBag.appendTo($('.mijlo-wrap')).removeClass('active');
      mijloBag.find('.content').css({'left': '-100%'});
      bagOpen = false;
    }
  });
  $('.show-mobile-nav').on('click', function(){
    $(this).siblings('.mobile-nav-links').slideToggle('slow');
  });
  $('.mobile-nav-links').on('click', 'a', function(){
    $('.mobile-nav-links').slideToggle('slow');
  });
  
  //enable infinite scroll
  $('.mijlo-posts').infinitescroll({
    loading:{
      beforeStart: function(opts){
        $('#loading').fadeIn();
      },
      msg: $('<div class="infscr-loading"></div>')
    },
    navSelector: 'ul.navigation',
    nextSelector: 'ul.navigation li.next a',
    debug: true,
    itemSelector: '.mijlo-posts .post-left, .mijlo-posts .post-right',
    errorCallback: function(err){
      if(err =='done'){
        $('#loading').text('No additional posts.');
        setTimeout(function(){
          $('#loading').slideUp();
        },2000);
      }
    }
  }, function(){
    $('#loading').fadeOut();
    setupThumbnails();
  });
  
  //enable social share buttons
  $('header ul').on('click', 'li.social', function(e){
    $this = $(this);
    var width  = 626,
      height = 436,
      left   = ($(window).width()  - width)  / 2,
      top    = (getWindowHeight() - height) / 2,
      opts   = 'status=1'+',width='+width+',height='+height+',top='+top+',left='+left+'menubar=no,toolbar=no,resizable=yes,scrollbars=yes';   
    if($this.hasClass('stumbleupon')){
      window.open('http://www.stumbleupon.com/submit?url='+encodeURIComponent(location.href), '', opts);
    }
    else if($this.hasClass('facebook')){
      window.open('https://www.facebook.com/sharer/sharer.php?u='+encodeURIComponent(location.href), 'facebook-share-dialog', opts);  
    }
    else if($this.hasClass('twitter')){
      window.open('http://twitter.com/share?url=' + encodeURIComponent(location.href), 'twitter', opts);   
    }
  });
  
  
  //initialize page
  var d = $(window).width();
  $('.navigation').hide();
  setupThumbnails(); //set thumbnail dimensions
  postDetails.css({'height': (getWindowHeight() - header.height())}); //set windows dimensions
  mijloBag.css({'height': (getWindowHeight() - header.height())}); //set bag dimensions
  if (!mobile) { //enable nicescroll for desktop
        $("html").niceScroll({cursorborderradius: "0",cursorwidth: "7px",cursorcolor: "#343434",scrollspeed: 35});
    }
  else{
    $('.mijlo-splash').remove();
    $('.mijlo-splash-scroll').show();
    headerTop.css({'position': 'absolute'});
  }
});