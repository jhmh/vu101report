#Vraag211.AllDisciplines.subfasen.R



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
    ToolUse.Subphase.j<-ToolUse.per.discipline[-dim(ToolUse.per.discipline)[1],ColNames.SubPhase.j]
      
    #define axis labels
    labs <- Tools[match(as.character(colnames(ToolUse.Subphase.j)),Tools[,"Variable.name"]),"Tool.name"]
    wr.lab <- wrap.labels(labs, 10)
    #plot
    barplot(ToolUse.Subphase.j/respondenten.per.discipline,beside=TRUE,main=SubPhases.Phase.i[j],
      names.arg=wr.lab,las=3,cex.names=0.7,col=Kleuren.disciplines,
      ylim=c(0,1),cex.lab=if(n.rows==1){0.8},
      ylab="% tool users in disciplines")
  }
}


  