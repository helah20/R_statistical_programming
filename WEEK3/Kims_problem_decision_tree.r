
#store the data in frame
outdoors <- data.frame(
  place =c("outdoors", "outdoors"),
  weather=c("sun", "Rain"),  
  prob=  c(0.4,0.6),
  value =c(100,0) 
  )
porch <- data.frame(
  place =c("porch","porch"),
  weather=c("sun", "Rain"),  
  prob=  c(0.4,0.6),
  value =c(90,20) 
)
indoors <- data.frame(
  place =c("indoors","indoors"),
  weather=c("sun", "Rain"),  
  prob=  c(0.4,0.6),
  value =c(40,50) 
)


#Function to calculate the best value  
bestChoice<-function(outdoors , porch ,indoors){
  #frams to store the sum of each choice
  comulativeValueForeOut=  data.frame(name1=c(outdoors[1,1]),total1=c(sum(outdoors$prob*outdoors$value)))
  comulativeValueForePorch=data.frame(name2=c(porch[1,1]),total2=c(sum(porch$prob*porch$value)))
  comulativeValueForeIn=   data.frame(name3=c(indoors[1,1]),total3=c(sum(indoors$prob*indoors$value)))

  # View(comulativeValueForeIn)

  # bestCom=max(comulativeValueForeOut$total1 ,
  #             comulativeValueForePorch$total2, 
  #             comulativeValueForeIn$total3) # to 
  
  Output=data.frame(
                    Location=c(comulativeValueForeOut$name1, 
                               comulativeValueForePorch$name2 ,
                               comulativeValueForeIn$name3
                              
                               ),
                    Total=c(
                      comulativeValueForeOut$total1 ,
                      comulativeValueForePorch$total2, 
                      comulativeValueForeIn$total3
                    )) #  create frame for comulative value
  
  the_best_option=Output$Location[Output$Total==max(Output$Total)]   #varible to store the max value for best choiced

  the_value_of_BO=max(Output$Total)
  print(Output)
  paste0('the pest choice is :' ,the_best_option, 'with value of : $', the_value_of_BO)
  
}
bestChoice(indoors,porch,outdoors)
  
