module lift5 (clk,rst,ra,rb,rc,rd,re,floor);
input clk,rst,ra,rb,rc,rd,re;
output reg [2:0] floor;
reg dir;
parameter A=0,B=1,C=2,D=3,E=4;
parameter UP=0,DOWN=1;

`ifdef CASE1
always @(posedge clk or posedge rst)
begin
	if (rst) floor<=A;
	else
	case(floor) 
	A: case(1)
		ra: floor<=A;
		rb: floor<=B;
		rc: floor<=C;
		rd: floor<=D;
		re: floor<=E;
		endcase
		
	B: case(dir)
		UP:
			case(1)
			rb: floor <= B;
			rc: floor <= C;
			rd: floor <= D;
			re: floor <= E;
			ra: floor <= A;
			endcase
		DOWN: 
			case(1)
			rb: floor <= B;
			ra: floor <= A;
			rc: floor <= C;
			rd: floor <= D;
			re: floor <= E;
			endcase
		endcase
		
	C: case(dir)
		UP:
			case(1)
			rc: floor <= C;
			rd: floor <= D;
			re: floor <= E;
			rb: floor <= B;
			ra: floor <= A;
			endcase
		DOWN: 
			case(1)
			rc: floor <= C;
			rb: floor <= B;
			ra: floor <= A;
			rd: floor <= D;
			re: floor <= E;				
			endcase
		endcase
	
	D: case(dir)
		UP:
			case(1)
			rd: floor <= D;
			re: floor <= E;
			rc: floor <= C;
			rb: floor <= B;
			ra: floor <= A;
			endcase
		DOWN: 
			case(1)
			rd: floor <= D;
			rc: floor <= C;
			rb: floor <= B;
			ra: floor <= A;
			re: floor <= E;				
			endcase
		endcase
		
	E: case(1)
	   re: floor<=E;
	   rd: floor<=D;
	   rc: floor<=C;
	   rb: floor<=B;
	   ra: floor<=A;
	   endcase
	endcase 
end
	
always @(posedge clk or posedge rst)
begin
	if (rst) dir<=UP;
	else 
	case(floor)
	A: 	case(1)
		ra:dir<=UP;
		rb:dir<=UP;
		rc:dir<=UP;
		rd:dir<=UP;
		re:dir<=DOWN;
		endcase
		
	B: case(dir)
		UP: case(1)
			rb:dir<=UP;
			rc:dir<=UP;
			rd:dir<=UP;
			re:dir<=DOWN;
			ra:dir<=UP;
			endcase
		DOWN: case(1)
			  rb:dir<=DOWN;
			  ra:dir<=UP;
			  rc:dir<=UP;
			  rd:dir<=UP;
			  re:dir<=DOWN;
			  endcase
		endcase
	
	C: case(dir)
		UP: case(1)
			rc:dir<=UP;
			rd:dir<=UP;
			re:dir<=DOWN;
			rb:dir<=DOWN;
			ra:dir<=UP;
			endcase
		DOWN: case(1)
			  rc:dir<=DOWN;
			  rb:dir<=DOWN;
			  ra:dir<=UP;
			  rd:dir<=UP;
			  re:dir<=DOWN;
			  endcase
		endcase
		
	D:  case(dir)
		UP: case(1)
			rd:dir<=UP;
			re:dir<=DOWN;
			rc:dir<=DOWN;
			rb:dir<=DOWN;
			ra:dir<=UP;
			endcase
		DOWN: case(1)
			  rd:dir<=DOWN;
			  rc:dir<=DOWN;
			  rb:dir<=UP;
			  ra:dir<=UP;
			  re:dir<=DOWN;
			  endcase
		endcase
	
	E: case(1)
	   re:dir<=DOWN;
	   rd:dir<=DOWN;
	   rc:dir<=DOWN;
	   rb:dir<=DOWN;
	   ra:dir<=UP;
	   endcase
	endcase
end
`endif

`ifdef CASEX
always @(posedge clk or posedge rst)
begin
	if (rst) floor<=A;
	else 
	case(floor)
	A: casex ({ra,rb,rc,rd,re})
	   5'b1xxxx: floor<=A;
	   5'b01xxx: floor<=B;
	   5'b001xx: floor<=C;
	   5'b0001x: floor<=D;
	   5'b00001: floor<=E;
	   endcase
	  
	B: case (dir)
		UP: casex ({rb,rc,rd,re,ra})
		   5'b1xxxx: floor<=B;
		   5'b01xxx: floor<=C;
		   5'b001xx: floor<=D;
		   5'b0001x: floor<=E;
		   5'b00001: floor<=A;
		   endcase 
		DOWN: casex ({rb,ra,rc,rd,re})
		      5'b1xxxx: floor<=B;
		      5'b01xxx: floor<=A;
		      5'b001xx: floor<=C;
		      5'b0001x: floor<=D;
			  5'b00001: floor<=E;
		      endcase
		endcase
		
	C: case (dir)
		UP: casex ({rc,rd,re,rb,ra})
		   5'b1xxxx: floor<=C;
		   5'b01xxx: floor<=D;
		   5'b001xx: floor<=E;
		   5'b0001x: floor<=B;
		   5'b00001: floor<=A;
		   endcase 
		DOWN: casex ({rc,rb,ra,rd,re})
		      5'b1xxxx: floor<=C;
		      5'b01xxx: floor<=B;
		      5'b001xx: floor<=A;
		      5'b0001x: floor<=D;
			  5'b00001: floor<=E;
		      endcase
		endcase
		
	D: case (dir)
		UP: casex ({rd,re,rc,rb,ra})
		   5'b1xxxx: floor<=D;
		   5'b01xxx: floor<=E;
		   5'b001xx: floor<=C;
		   5'b0001x: floor<=B;
		   5'b00001: floor<=A;
		   endcase 
		DOWN: casex ({rd,rc,rb,ra,re})
		      5'b1xxxx: floor<=D;
		      5'b01xxx: floor<=C;
		      5'b001xx: floor<=B;
		      5'b0001x: floor<=A;
			  5'b00001: floor<=E;
		      endcase
		endcase
		
	E: casex ({re,rd,rc,rb,ra})
	   5'b1xxxx: floor<=E;
	   5'b01xxx: floor<=D;
	   5'b001xx: floor<=C;
	   5'b0001x: floor<=B;
	   5'b00001: floor<=A;
	   endcase
	endcase
	
end

always @(posedge clk or posedge rst)
begin
	if (rst) dir<=UP;
	else 
	case(dir)
	UP: case(floor)
		A: casex({ra,rb,rc,rd,re})
		   5'b00001: dir<=DOWN;
		   endcase
		B: casex({rb,rc,rd,re,ra})
		   5'b0001x: dir<=DOWN;
		   endcase
        C: casex({rc,rd,re,rb,ra})
		   5'b001xx: dir<=DOWN;
		   5'b0001x: dir<=DOWN;
		   endcase
		endcase 
	DOWN: case(floor)
		B: casex({rb,ra,rc,rd,re})
		   5'b001xx: dir<=UP;
		   5'b0001x: dir<=UP;
		   endcase
		C: casex({rc,rb,ra,rd,re})
		   5'b0001x: dir<=UP;
		   endcase
        D: casex({rd,re,rc,rb,ra})
		   5'b00001: dir<=UP;		   
		   endcase
		endcase 
	endcase
end
`endif

`ifdef BOOLEAN
assign a2b = !ra && rb;
assign a2c = !ra && !rb && rc;
assign a2d = !ra && !rb && !rc && rd;
assign a2e = !ra && !rb && !rc && !rd && re; 

assign e2a = ra && !rb && !rc && !rd && !re; 
assign e2b = rb && !rc && !rd && !re; 
assign e2c = rc && !rd && !re; 
assign e2d = rd && !re; 

assign b2a = (dir==UP) && ra && !rb && !rc && !rd || (dir==DOWN) && ra && !rb;
assign b2c = (dir==UP) && !rb && rc || (dir==DOWN) && !ra && !rb && rc;
assign b2d = (dir==UP) && !rb && !rc && rd || (dir==DOWN) && !ra && !rb && !rc && rd;
assign b2e = (dir==UP) && !rb && !rc && !rd && re || (dir==DOWN) && !ra && !rb && !rc && !rd && re;

assign c2a = (dir==UP) && ra && !rb && !rc && !rd || (dir==DOWN) && ra && !rb && !rc;
assign c2b = (dir==UP) && rb && !rc && !rd || (dir==DOWN) && rb && !rc;
assign c2d = (dir==UP) && !rc && rd || (dir==DOWN) && !ra && !rb && !rc && rd;
assign c2e = (dir==UP) && !rc && !rd && re || (dir==DOWN) && !ra && !rb && !rc && !rd && re;

assign d2a = (dir==UP) && ra && !rb && !rc && !rd || (dir==DOWN) && ra && !rb && !rc && !rd;
assign d2b = (dir==UP) && rb && !rc && !rd || (dir==DOWN) && rb && !rc && !rd;
assign d2c = (dir==UP) && !rb && rc && !rd || (dir==DOWN) && !rb && rc && !rd;
assign d2e = (dir==UP) && !rb && !rc && !rd && re || (dir==DOWN) && !rb && !rc && !rd && re;

always @(posedge clk or posedge rst) begin
    if (rst) floor <= A;
    else 
	case (floor)
		A: if (a2b) floor<=B;
		   else if (a2c) floor<=C;
		   else if (a2d) floor<=D;
		   else if (a2e) floor<=E;
		B: if (b2a) floor<=A;
		   else if (b2c) floor<=C;
		   else if (b2d) floor<=D;
		   else if (b2e) floor<=E;
		C: if (c2a) floor<=A;
		   else if (c2b) floor<=B;
		   else if (c2d) floor<=D;
		   else if (c2e) floor<=E;
		D: if (d2a) floor<=A;
		   else if (d2b) floor<=B;
		   else if (d2c) floor<=C;
		   else if (d2e) floor<=E;
		E: if (e2a) floor<=A;
		   else if (e2b) floor<=B;
		   else if (e2c) floor<=C;
		   else if (e2d) floor<=D;
		default: floor <= floor;
	endcase
end

always @(posedge clk or posedge rst)
begin
    if (rst) dir<=UP;
    else 
    case(dir)
    UP: if (floor==A && !ra && !rb && !rc && !rd && re) dir<=DOWN;
        else if (floor==B && !rb && !rc && !rd && re) dir<=DOWN;
        else if (floor==C && ( ra && !rb && !rc && !rd && !re || !rc && !rd && re)) dir<=DOWN;
        else if (floor==D && ( !rd && re || rc && !rd && !re)) dir<=DOWN;
        
    DOWN: if (floor==B && (ra && !rb || !ra && !rb && rc)) dir<=UP;
		  else if (floor==C && (!ra && !rb && !rc && rd)) dir<=UP;
	      else if (floor==D && ra && !rb && !rc && !rd) dir<=UP;
		  else if (floor==E &&  ra && !rb && !rc && !rd && !re) dir<=UP;
		  else dir<=dir;
    endcase 
end
`endif
endmodule
