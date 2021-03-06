#Vraag131.top3.fasen.R


for(i in 1:length(PhaseResearchCycle))
{ 
  ##PLOTS

  SubPhases.Phase.i<-SubPhases[grep(PhaseResearchCycle[i],SubPhases)]
  n.rows<-ceiling(length(SubPhases.Phase.i)/2)
  win.graph(8,n.rows*4)
  par(mfrow=c(n.rows,2))
  for(j in 1:length(SubPhases.Phase.i))
  {
    par(mar = c(5,8,4,2) +0.1)

    ColNames.SubPhase.j <- as.character(Tools[which(Tools[,"SubPhase"]==SubPhases.Phase.i[j]),"Variable.name"])
    ToolUse.SubPhase.j<- ToolUse.totaal[ColNames.SubPhase.j]
    ToolUse.SubPhase.j<- ToolUse.SubPhase.j[order(-ToolUse.SubPhase.j)]
  
  #set en wrap labels voor y-as
  labs <- Tools[match(as.character(names(ToolUse.SubPhase.j[1:3])),Tools[,"Variable.name"]),"Tool.name"]
  wr.lab <- wrap.labels(labs, 10)
  fill <- Tools[match(as.character(names(ToolUse.SubPhase.j[1:3])),Tools[,"Variable.name"]),"UB.support"]
  
  # plot gebruikers top 3 in horizontale bargraph 
  barplot(ToolUse.SubPhase.j[1:3], main=SubPhases.Phase.i[j],xlim=c(0,max(ToolUse.totaal)),
          xlab="Aantal gebruikers: VU top 3\n (dichte arcering=UB support)",
          cex.names=0.7,cex.main=1,horiz=T,las=1,cex.lab=if(n.rows==1){0.8},
          names.arg=wr.lab,col=Kleuren[i],density=((fill+1)^2)*20)
  }
}


