import Konami from 'konami';
import PhotoSwipeLightbox from 'photoswipe-lightbox';
import PhotoSwipe from 'photoswipe';

new Konami(() => {
  document.querySelectorAll('[data-real]').forEach((i) => {
    i.classList.add("hidden")
  })
  document.querySelectorAll('[data-nno]').forEach((i) => {
    i.classList.remove("hidden")
  })
  const lightbox = new PhotoSwipeLightbox({
    gallery: '#egg a',
    pswpModule: () => import('photoswipe'),
    showHideAnimationType: 'zoom',
  });
  lightbox.init();

})
