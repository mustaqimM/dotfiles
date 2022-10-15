domainBypass("ez4short.com", () => {
  awaitElement("a.btn.btn-success.btn-lg.get-link[href]", a => {
    a.click()
    //safelyNavigate(a.href)
  })
})

domainBypass("stfly.me", () => {
  awaitElement("a.btn.btn-success.btn-lg.get-link[href]", a => {
    safelyNavigate(a.href)
  })
})

domainBypass("try2link.com", () => {
  ifElement("a.btn.btn-success.btn-lg.get-link.disabled", d => {
    awaitElement("a.btn.btn-success.btn-lg.get-link[href]:not(.disabled)", d => {
      d.click()
    })
  })
})

domainBypass("newforex.online", () => {
  awaitElement("a#go_d[href]", a => {
    a.click()
    //safelyNavigate(a.href)
  })
})
domainBypass("forex-gold.net", () => {
  awaitElement("a#go_d[href]", a => {
    a.click()
    //safelyNavigate(a.href)
  })
})
domainBypass("mobi2c.com", () => {
  awaitElement("a#go_d[href]", a => {
    a.click()
    //safelyNavigate(a.href)
  })
})
