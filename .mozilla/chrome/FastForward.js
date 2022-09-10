domainBypass("techmody.io", () => {
  ensureDomLoaded(() => {
    awaitElement("#btn6[href]", a => {
      a.onclick()
    })
  })
})

domainBypass("try2link.com", () => {
  ifElement("a.btn.btn-success.btn-lg.get-link.disabled", d => {
    awaitElement("a.btn.btn-success.btn-lg.get-link[href]:not(.disabled)", d => {
      d.click()
    })
  })
})
