clear
import delimited using "mba2412B.csv", delimiter(",")
rename ïdate date
rename cinemafenz~g cfeng
rename makerfenzh~g mfeng
drop cfeng
order budget,after(revenues)
gen pvtProCP = log(makermin)
gen pubProCP = log(makerguo)
gen rPR = log(paipian)
gen pvtPreCP = log(chupinmin)
gen pubPreCP = log(chupinguo)
gen RRforPP = log(mfeng)
gen tPrice = log(price)
gen rP = period
drop makerguo makermin chupinguo chupinmin faxingmin price mfeng paipian period
order pvtProCP, after(revenues)
order pubProCP, after(pvtProCP)
order pvtPreCP, after(pubProCP)
order pubPreCP, after(pvtPreCP)
order budget, after(pubPreCP)
order RRforPP, after(budget)
order tPrice, after(RRforPP)
order rP, after(tPrice)
order rating,after(rP)
order rPR,after(rating)
gen PubDistP = faxingguo
drop faxingguo

regress revenues pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating rPR

/* whtie test */
whitetst
estat hettest pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating rPR

gen time= n
tsset time 
dwstat

regress revenues pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating

whitetst
estat hettest pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating

dwstat


/* WLS */
predict r, resid
gen logusq=ln(r^8)
regress logusq pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating 
predict g, xb 
gen h=exp(g)

regress revenues pvtProCP pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating [aweight = h]
dwstat


/* IV  */
ivreg revenues pubProCP pvtPreCP pubPreCP budget RRforPP tPrice rP rating (pvtProCP  = sort) [aweight = h]

/* delete budget tPrice pvtPreCP pubProCP */
ivreg2 revenues pubPreCP RRforPP rP rating (pvtProCP  = sort) [aweight = h]

/* hausman test */
quietly ivreg revenues pubPreCP RRforPP rP rating (pvtProCP  = sort) 
est store IV_reg
quietly regress revenues pvtProCP pubPreCP RRforPP rP rating 
est store LS_reg
hausman IV_reg LS_reg  




