int cellSize = 30;
int cellsX;
int cellsY;
Cell[] cells;
int secGenCells=10;
int secGenBias=0;

void setup(){
  fullScreen(P3D);
  frameRate(12);
  cellSize=30;
  cellsX=width/cellSize;
  cellsY=height/cellSize;
  cells=new Cell[cellsX*cellsY];
  populate("random");
}

void draw(){
  secGenCells=0;
  background(0);
  translate(0,0,100*abs(sin(.25*float(millis())/1000)));
  for(int i=0; i<cells.length; i++){
    cells[i].drawCell(i);
  }
  for(int i=0; i<cells.length; i++){
    cells[i].isActive=cells[i].futureState;
  }
  print(secGenCells);
  if(secGenCells<1){
    secGenBias++;
    if(secGenBias>3){
      populate("random");
      secGenBias=0;
    }
  }
}

void populate(String type){
  switch (type){
      case "random":
      for(int i=0; i<cells.length; i++){
        if(random(1)>.8){
          cells[i]=new Cell(true);
        }else{
          cells[i]=new Cell(false);
        }
      }
      break;
      
      case "":
      
      break;
  }
}
