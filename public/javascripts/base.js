// Onload function
Event.observe(window, 'load', function() {
  // Make the flash message go away
  if ($('flash_notice') != null) Effect.Fade('flash_notice', {duration: 2.0});
});
