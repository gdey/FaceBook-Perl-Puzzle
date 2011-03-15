
// First let's define some helper functions.

function range( x,y) {
   var returnArray = [];
   for( i = x; i <= y; i++ ) {
     returnArray[i] = i;
   }
   return returnArray;
}
function map( aFun, anArray ) {
   var returnArray = [];

   for( i = 0; i < anArray.length; i++ ) {
     returnArray[i] = aFun(anArray[i]);
   }
   return returnArray;
}

function join( anArray, aSep ){

  var string = "";
  var sep = "";
  if (aSep)
    sep = aSep;
  for( i = 0; i < anArray.length; i++ ){
     string += anArray[i] + sep;
  }
  return string;

}

var $num_entry = 15;

alert( join( map( function(x){
     return ((x % 3 != 0 || x % 5 != 0)?
             (x % 5)?
             (x % 3)? ''
                    : 'Hoppity'
                    : 'Hophop'
                    : 'Hop' 
                    );
  }, range(1,$num_entry) ), "\n" ) ); 

