int cellSize = 30;
int cellsX;
int cellsY;
Cell[] cells;
int secGenCells=10;
int secGenBias=0;
PShader blur;

void setup(){
  fullScreen(P3D);
  blur = loadShader("blur.glsl"); 
  frameRate(30);
  cellSize=30;
  cellsX=width/cellSize;
  cellsY=height/cellSize;
  cells=new Cell[cellsX*cellsY];
  populate("random");
}

void draw(){
  secGenCells=0;
  background(0);
  float trans = 500*abs(sin(.25*float(millis())/1000));
  translate(0, 0, trans);
  for(int i=0; i<cells.length; i++){
    cells[i].drawCell(i);
  }
  for(int i=0; i<cells.length; i++){
    cells[i].isActive=cells[i].futureState;
  }
  if(secGenCells<1){
    secGenBias++;
    if(secGenBias>3){
      populate("random");
      secGenBias=0;
    }
  }
  blur.set("blurSize", int(5+200*abs(sin(.25*float(millis())/1000))));
  blur.set("sigma", 5+20*abs(sin(.25*float(millis())/1000))); 
  filter(blur);
}

void populate(String type){
  switch (type){
      case "random":
        if(cells[0] == null){
          for(int i=0; i<cells.length; i++){
            if(random(1)>.8){
              cells[i]=new Cell(true);
            }else{
              cells[i]=new Cell(false);
            }
          }
        }else{
          for(int i=0; i<cells.length; i++){
            if(random(1)>.8){
              cells[i].isActive=true;
              cells[i].visitHistory=0;
            }else{
              cells[i].isActive=false;
              cells[i].visitHistory=0;
            }
          }
        }
      break;
      
      case "":
      
      break;
  }
}
