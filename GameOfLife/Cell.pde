class Cell{
  
  boolean isActive;
  boolean futureState;
  color[] colors = {color(160,200,255),color(128,64,128),color(46,64,255)};
  int visitHistory = 0;
  
  Cell (boolean act) {
    isActive = act;
  }
  
  void drawCell(int i){
    noStroke();
    if (isActive){
      if(visitHistory < colors.length){
        fill(colors[visitHistory]);
      }else{fill(colors[colors.length-1]);}
      rect(i%cellsX*cellSize,i/cellsX*cellSize,cellSize,cellSize,cellSize/3);
      visitHistory++;
      
    }else{
        visitHistory = 0;
    }
    if(visitHistory==2){
        secGenCells++;
    }
    setState(checkCells(i));
  }
  
  int checkCells(int cellNum){
    int n = 0;
    for(int j = -1; j<2; j++){
      for(int i = -1; i<2; i++){
        int inRow = ((cellsX*cellsY)+cellNum+j*cellsX)%(cellsX*cellsY);
        int actCell = ((cellsX+inRow+i)%cellsX)+floor(inRow/cellsX)*cellsX;
        if(cells[actCell].isActive){
          n++;
        }
      }
    }
    if(isActive){n--;}
    return n;
  }
  
  void setState(int neigh){
    if(isActive && neigh>3){
      futureState = false;
    }
    if(isActive && neigh<2){
      futureState = false;
    }
    if(!isActive && neigh==3){
      futureState = true;
    }
  }
}
