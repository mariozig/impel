$ ->
  $container = $("#container")
  $container.imagesLoaded ->
    $container.isotope
      itemSelector: ".post"