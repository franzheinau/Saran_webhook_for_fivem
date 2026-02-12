window.addEventListener('message', (event) => {
  if (event.data.action === 'open') {
    document.body.classList.add('active')
  }

  if (event.data.action === 'close') {
    document.body.classList.remove('active')
  }
})

document.getElementById('kirim').addEventListener('click', () => {
  const saran = document.querySelector('textarea').value
  if (!saran) return

  fetch(`https://${GetParentResourceName()}/sendSaran`, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ saran })
  })

  document.querySelector('textarea').value = ''
})

document.getElementById('tutup').addEventListener('click', () => {
  fetch(`https://${GetParentResourceName()}/close`, {
    method: 'POST'
  })
})
