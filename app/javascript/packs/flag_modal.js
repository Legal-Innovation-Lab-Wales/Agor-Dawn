const open_modal_buttons = document.querySelectorAll('[data-open-modal]')

open_modal_buttons.forEach(button => {
  button.addEventListener('click', () => {
    console.log(button.dataset)
  })
})