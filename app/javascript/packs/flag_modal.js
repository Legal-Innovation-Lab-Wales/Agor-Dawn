const flag_modal = document.getElementById('flag-modal'),
      flag_buttons = document.querySelectorAll('.flag.link-primary')

flag_buttons.forEach(button => {
  button.addEventListener('click', () => {
    flag_modal.style.display = 'block'
    flag_modal.classList.add('show')
  })
})