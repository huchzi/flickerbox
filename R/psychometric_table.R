psychometric_table <- function(name, presets = flickerbox::presets){
  rt <- read.resultFile(name)
  
  fulltable <- rt[-c(1:7),] #response table
  
  # Here, we find the right used procedure
  x <- which(grepl("Strategie", rt[,1]))
  l <- length(x)
  
  if(l!=0) {
    set_Method <- "BP"
    row_num3 <- which(grepl("BestPEST: Schwelle erreicht!", fulltable$category))
    fulltable[row_num3, c(7:10)] <- fulltable[row_num3,c(3:6)]
    fulltable[row_num3, 2] <- "gesehen"
    fulltable <- na.omit(fulltable)
  } else {
    set_Method <- "SC"
    # here gesehen added to the last trial and keep the results 
    row_num <- which(grepl("Down: Schwelle erreicht!", fulltable$category))
    fulltable[row_num, c(7:10)] <- fulltable[row_num,c(3:6)]
    fulltable[row_num, 2] <- "gesehen"
    row_num2 <- which(grepl("Up: Schwelle erreicht!", fulltable$category))
    fulltable[row_num2, c(7:10)] <- fulltable[row_num,c(3:6)]
    fulltable[row_num2, 2] <- "gesehen"
    fulltable <- na.omit(fulltable) 
    # must add a part that check which type of stimuli (center or surround)
  }
  
  fulltable[,1] <- as.factor(fulltable[,1])
  #using only the red_surround contrast, because the contrasts are changed proportionally 
  fulltable <- cbind.data.frame(fulltable[,2], fulltable[,7])
  colnames(fulltable) <- c("decision", "contrast")
  
  # finally we create the table 
  if (set_Method == "SC") {
    if (sum(any(rt=="Up: Schwelle erreicht!"), na.rm = TRUE) == 1){
      up <- rt[which(grepl("Up: Schwelle", rt[,1])),3]
      up <- cbind.data.frame(as.factor("gesehen"), up)
      colnames(up) <- c("decision", "contrast")
      fulltable <- rbind.data.frame(fulltable, up)
    } else if (sum(any(rt=="Up: Schwelle erreicht!"), na.rm = TRUE) == 0){
      up <- NaN
    }
    if (sum(any(rt=="Down: Schwelle erreicht!"), na.rm = TRUE) == 1){
      down <- rt[which(grepl("Down: Schwelle", rt[,1])),3]
      down <- cbind.data.frame(as.factor("gesehen"), down)
      colnames(down) <- c("decision", "contrast")
      fulltable <- rbind.data.frame(fulltable, down)
    } else if (sum(any(rt=="Down: Schwelle erreicht!"), na.rm = TRUE) == 0){
      down <- NaN
    }
  } else if (set_Method == "BP") {
    if (sum(any(rt=="Strategie"), na.rm = TRUE) > 1){
      resp <- fulltable[which(grepl("Strategie", fulltable[,1])),3]
      resp <- cbind.data.frame(as.factor("gesehen"), resp)
      colnames(resp) <- c("decision", "contrast")
      fulltable <- rbind.data.frame(fulltable, resp)
    }
  }
  fulltable[,2] <- fulltable[,2]/max(fulltable[,2]) # here the contrasts are comprised between 0 & 1
  return(fulltable)
}
