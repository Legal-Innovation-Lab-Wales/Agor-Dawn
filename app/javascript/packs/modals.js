const modals = Array.from(document.querySelectorAll('[data-modal]')),
      open_modal_buttons = document.querySelectorAll('[data-open-modal]'),
      close_modal_buttons = document.querySelectorAll('[data-close-modal]'),
      backdrop = document.getElementById('backdrop'),
      open_modal = modal => {
        backdrop.style.display = 'block'
        modal.style.display = 'block'
      },
      close_modal = modal => {
        backdrop.style.display = 'none'
        modal.style.display = 'none'
      }

open_modal_buttons.forEach(button => {
  button.addEventListener('click', () => {
    const target_modal = modals.find(modal => modal.dataset.modal == button.dataset.openModal)
    open_modal(target_modal)
  })
})

close_modal_buttons.forEach(button => {
  button.addEventListener('click', () => {
    const target_modal = modals.find(modal => modal.dataset.modal == button.dataset.closeModal)
    close_modal(target_modal)
  })
})

window.onclick = event => {
  modals.forEach(modal => {
    if (event.target === modal) close_modal(modal)
  })
}