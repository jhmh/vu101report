#Vraag211.PerDiscipline.subfasen.R



for(d in 1:length(Disciplines))
{ 
  for(i in 1:length(PhaseResearchCycle))
  { 
    # Print heading
    par(mar = c(6,6,4,1) +0.1)
    #selecteer SubPhases behoorden bij PhaseResearchCyclie[i]
    SubPhases.Phase.i<-SubPhases[grep(PhaseResearchCycle[i],SubPhases)]
    n.rows<-ceiling(length(SubPhases.Phase.i)/2)
    win.graph(14,n.rows*4)
    par(mfrow=c(n.rows,2))
    for(j in 1:length(SubPhases.Phase.i))
    {
      par(mar = c(6,6,4,1) +0.1)
      #selecteer kolommen/tools uit subfase[j] van de research cycle
      ColNames.SubPhase.j <- as.character(Tools[which(Tools[,"SubPhase"]==SubPhases.Phase.i[j]),"Variable.name"])
      #selecteer tools van subphase j uit phase i in ToolUse.per.Discipline
      ToolUse.Subphase.j<-ToolUse.per.discipline[,ColNames.SubPhase.j]
      ToolUse.Subphase.j.OECD<-ToolUse.per.discipline.OECD[,ColNames.SubPhase.j]
      
      #sort tools from ToolUse.Subphase.j by difference in tooluse 
      ToolUse.Subphase.j<-ToolUse.Subphase.j[,order(-ToolUse.Subphase.j[d,])]
      ToolUse.Subphase.j.OECD<-ToolUse.Subphase.j.OECD[,colnames(ToolUse.Subphase.j)]
      
      #define axis labels
      labs <- Tools[match(as.character(colnames(ToolUse.Subphase.j)),Tools[,"Variable.name"]),"Tool.name"]
      wr.lab <- wrap.labels(labs, 10)
      #plot
      plotdata<- cbind((ToolUse.Subphase.j[d,]/respondenten.per.discipline[d])*100,
                   (ToolUse.Subphase.j["totaal.VU",]/sum(respondenten.per.discipline))*100,
                   (ToolUse.Subphase.j.OECD[d,]/respondenten.per.discipline.OECD[d])*100)
      colnames(plotdata) <- c(Disciplines[d],"VU","OECD")
      
      barplot(t(plotdata),beside=TRUE,main=paste(Disciplines[d],SubPhases.Phase.i[j],sep=' - '),
              names.arg=wr.lab,las=3,cex.names=0.7,col=c(Kleuren[i],Kleuren.VU,Kleuren.OECD),
              ylim=c(0,100),cex.lab=if(n.rows==1){0.8},
              ylab=paste("% of of respondents ",Disciplines[d]))
    }
  }
}

  