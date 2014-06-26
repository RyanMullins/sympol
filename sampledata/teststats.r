library('rjson')

results <- fromJSON(file='./testdata.json')

for (i in 1:10) {
    if ((i %% 2) != 0) {
        compCert <- 0

        for (j in 1:30) {
            compCert <- (compCert + results[[j]][[i]]$associations[[1]]$certainty)
        }

        compMean <- (compCert / 30)

        print('Association Certainty')
        print('Symbol Name')
        print(results[[1]][[i]]$associations[[1]]$symbol$name)
        print('SUM OF ALL')
        print(compCert)
        print('MEAN')
        print(compMean)
        writeLines('\n\n')
    } else {
        searchTime <- 0

        for (j in 1:30) {
            searchTime <- (searchTime + results[[j]][[i]]$elapsedTime)
        }

        searchMean <- (searchTime / 30)

        print('Search Time')
        print('Symbol Name')
        print(results[[1]][[i]]$targetSymbol$name)
        print('SUM OF ALL')
        print(sprintf('%f', searchTime))
        print('MEAN')
        print(sprintf('%f', searchMean))
        writeLines('\n\n')
    }
}