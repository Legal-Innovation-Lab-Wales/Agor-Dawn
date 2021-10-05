const open_modal_resources = document.querySelectorAll('[data-open-modal]'),
      flag_modal = document.querySelector('[data-modal="flag-modal"]'),
      form = flag_modal.querySelector('form'),
      resource_type = form.querySelector('input[name="flag[resource_type]"]'),
      resource_id = form.querySelector('input[name="flag[resource_id]"]')

open_modal_resources.forEach(resource => {
  resource.addEventListener('click', () => {
    resource_type.value = resource.dataset.resourceType
    resource_id.value = resource.dataset.resourceId
  })
})
