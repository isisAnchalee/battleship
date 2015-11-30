//  var WATER = 0;
//  function Tile(){
//   tTile = new Sprite(scene, "grass.png", 32, 32);
//   tTile.setSpeed(0);
//   tTile.state = GRASS;
//   tTile.images = ["http://orig14.deviantart.net/dfb1/f/2013/047/d/0/water_tile_by_pix3m-d511mbk.gif"]
//   tTile.row = 0;
//   tTile.col = 0;
 
//   Tile.setState = function(state){
//    this.state = state;
//    this.setImage(this.images[this.state]);
//   } // end setState
 
//   Tile.getRow = function(){
//    return this.row;
//   } // end getRow
 
//   Tile.getCol = function(){
//    return this.col;
//   } // end getCol;
 
//   Tile.getState = function(){
//    return this.state;
//   } // end getState
 
//   Tile.checkMouse = function(){
//    if (this.isClicked()){
   
//     newState = this.state;
//     newState++;
//     if (newState >= NUMSTATES){
//      newState = 0;
//     }
   
//     this.setState(newState);
//    } // end if
//   } // end if
 
//   return Tile;
//  }

// function setupTiles(ROWS, COLS){
//   tileset = new Array(ROWS);
//   for (row = 0; row < ROWS; row++){
//     tRow = new Array(COLS);
//     for (col = 0; col < COLS; col++){
//       tRow[col] = new Tile();
//       xPos = 16 + (32 * col);
//       yPos = 16 + (32 * row);
//       tRow[col].setPosition(xPos, yPos);
//       tRow[col].row = row;
//       tRow[col].col = col;
//     } // end col for loop
//     tileset[row] = tRow;
//   } // end row for loop;

//   setupTiles(10, 10)
// } // end setupTiles