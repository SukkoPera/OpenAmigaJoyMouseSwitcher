
// Parameters
$fn=90;
length=74;
bigWidth=68;
smallWidth=32;
part1=37;
part2=20;

thickness=2;
thickness_h=1.8;

support_thickness=4;
support_length=3.7;
tolerance=0.6;

hole_x1=3.3;
hole_y1=16.8;
hole_x2=bigWidth-6;
hole_y2=length-25;
hole_r=2.2;
hole_ri1=1.5;
hole_re=3.5;
hole_rs=1.1;

db9andcard_height=14.2;
db9top_thickness=2.7;
db9top_thickness_h=2;
db9top_thickness_h2=2.2;
db9_side=6;
db9top=9.8;
cardthickness=1.8;

led_r=3;
led_x1=27.20;
led_y1=57.5;
led_x2=40;
led_y2=57.5;

//0 for design, 1 to generate stl for bottom, 2 to generate stl for top
which=2;

if(which==0 || which ==1)
//Bottom
difference() {
 union() {
     
    //base     
    linear_extrude(height = thickness_h) polygon([[0,0],[0,length],[bigWidth,length],[bigWidth,length-part1],[smallWidth,part2],[smallWidth,0]]);

    //side
    linear_extrude(height = support_thickness+db9andcard_height*0.6) polygon(points=[[0,0],[0,length],[bigWidth,length],[bigWidth,length-part1],[smallWidth,part2],[smallWidth,0],[0-thickness,0],[0-thickness,length],[bigWidth+thickness,length],[bigWidth+thickness,length-part1-thickness],[smallWidth+thickness,part2-thickness],[smallWidth+thickness,0]], paths=[[0,1,2,3,4,5],[6,7,8,9,10,11]],convexity=10);
         
    //DB9 supports    
    linear_extrude(height = support_thickness) polygon([[0,length],[bigWidth,length],[bigWidth,length-support_length],[0,length-support_length]]);
    linear_extrude(height = support_thickness) polygon([[0,0],[smallWidth,0],[smallWidth,support_length],[0,support_length]]);

    //holes
    linear_extrude(height = support_thickness) translate([hole_x1,hole_y1,0]) circle(r=hole_r);     
    linear_extrude(height = support_thickness) translate([hole_x2,hole_y2,0]) circle(r=hole_r);   
     }
    //For screw
    linear_extrude(height = support_thickness) translate([hole_x1,hole_y1,0]) circle(r=hole_ri1); 
    linear_extrude(height = support_thickness) translate([hole_x2,hole_y2,0]) circle(r=hole_ri1); 
    linear_extrude(height = 0.7) translate([hole_x1,hole_y1,0]) circle(r=hole_re); 
    linear_extrude(height = 0.7) translate([hole_x2,hole_y2,0]) circle(r=hole_re); 
 }


//Top
 
separation=1;
 
 if(which==0 || which==2)  translate ([0,0, separation]) difference() {
 
    union() {
         
            //base     
            translate([0,0,support_thickness+db9andcard_height]) linear_extrude(height = thickness_h) polygon([[0,0],[0,length],[bigWidth,length],[bigWidth,length-part1],[smallWidth,part2],[smallWidth,0]]);

            //side
             translate([0,0,support_thickness+db9andcard_height*0.6-tolerance]) linear_extrude(height = db9andcard_height*0.4+thickness_h+tolerance) polygon(points=[[0,0],[0,length],[bigWidth,length],[bigWidth,length-part1],[smallWidth,part2],[smallWidth,0],[0-thickness,0],[0-thickness,length],[bigWidth+thickness,length],[bigWidth+thickness,length-part1-thickness],[smallWidth+thickness,part2-thickness],[smallWidth+thickness,0]], paths=[[0,1,2,3,4,5],[6,7,8,9,10,11]],convexity=10);

            //between db
            translate([0,0,support_thickness+cardthickness]) linear_extrude(height = db9andcard_height-cardthickness) polygon([[smallWidth+tolerance,length],[bigWidth-smallWidth-tolerance,length],[bigWidth-smallWidth-tolerance,length-support_thickness],[smallWidth+tolerance,length-support_thickness]]);
            //triangle to enforce
            translate([smallWidth+tolerance+bigWidth-smallWidth-tolerance-(smallWidth+tolerance),0,0]) rotate(a=[0,-90,0]) linear_extrude(height = bigWidth-smallWidth-tolerance-(smallWidth+tolerance)) polygon([[db9andcard_height-cardthickness+support_thickness+cardthickness,length-support_thickness],[db9andcard_height-cardthickness+support_thickness+cardthickness,length-support_thickness*2],[support_thickness+cardthickness,length-support_thickness]]);
         
            //db9 top support (amiga side)  
            translate([db9_side,0,thickness_h+db9andcard_height]) union() {  
                 linear_extrude(height=db9top_thickness_h) polygon([[0,db9top_thickness],[0,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness]]);     
                     
                 translate([0,0,-db9top_thickness_h*2]) linear_extrude(height=db9top_thickness_h*3) polygon([[0,db9top_thickness+db9top],[0,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top]]); 
            }
                 
            //db9 top support  (joy side)
            translate([db9_side,length-db9top_thickness-db9top-db9top_thickness_h2,thickness_h+db9andcard_height]) union() {  
                 linear_extrude(height=db9top_thickness_h) polygon([[0,db9top_thickness],[0,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness]]);     
                     
                 translate([0,-db9top-db9top_thickness_h2,-db9top_thickness_h*2]) linear_extrude(height=db9top_thickness_h*3) polygon([[0,db9top_thickness+db9top],[0,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top]]); 
            }
                
            //db9 top support (mouse side)     
            translate([bigWidth-smallWidth+db9_side,length-db9top_thickness-db9top-db9top_thickness_h2,thickness_h+db9andcard_height]) union() {  
                 linear_extrude(height=db9top_thickness_h) polygon([[0,db9top_thickness],[0,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness+db9top],[smallWidth-db9_side*2,db9top_thickness]]);     
                     
                 translate([0,-db9top-db9top_thickness_h2,-db9top_thickness_h*2]) linear_extrude(height=db9top_thickness_h*3) polygon([[0,db9top_thickness+db9top],[0,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top+db9top_thickness_h2],[smallWidth-db9_side*2,db9top_thickness+db9top]]); 
        }
       
     //Support for screw   
     translate([0,0,support_thickness+cardthickness]) linear_extrude(height = db9andcard_height-cardthickness) translate([hole_x1,hole_y1,0]) circle(r=hole_r);     
     translate([0,0,support_thickness+cardthickness]) linear_extrude(height = db9andcard_height-cardthickness) translate([hole_x2,hole_y2,0]) circle(r=hole_r);
    //Enforce support for screw  
    translate([hole_x1,hole_y1,(support_thickness+cardthickness)*2]) rotate_extrude() translate([hole_r,0,0]) polygon([[0,0],[0,(db9andcard_height-cardthickness)*0.6],[2,(db9andcard_height-cardthickness)*0.6]]);
    translate([hole_x2,hole_y2,(support_thickness+cardthickness)*2]) rotate_extrude() translate([hole_r,0,0]) polygon([[0,0],[0,(db9andcard_height-cardthickness)*0.6],[2,(db9andcard_height-cardthickness)*0.6]]);
      
     //Support for leds   
     translate([0,0,db9andcard_height-db9top_thickness_h]) linear_extrude(height = db9top_thickness_h*3) translate([led_x1,led_y1,0]) circle(r=led_r*1.6);
    translate([0,0,db9andcard_height-db9top_thickness_h])  linear_extrude(height = db9top_thickness_h*3) translate([led_x2,led_y2,0]) circle(r=led_r*1.6);   
    
    }

     //hole for leds
    translate([0,0,db9andcard_height-db9top_thickness_h]) union() {
        linear_extrude(height = db9top_thickness_h*5) translate([led_x1,led_y1,db9andcard_height-db9top_thickness_h]) circle(r=led_r);
        linear_extrude(height = db9top_thickness_h*5) translate([led_x2,led_y2,db9andcard_height-db9top_thickness_h]) circle(r=led_r);   
    }
    
    //hole for screw
    translate([0,0,support_thickness]) union() {
        linear_extrude(height = 5) translate([hole_x1,hole_y1,0]) circle(r=hole_rs); 
        linear_extrude(height = 5) translate([hole_x2,hole_y2,0]) circle(r=hole_rs); 
   
    }
    
}


 
