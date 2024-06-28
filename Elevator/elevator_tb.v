module tb;
reg rst=1;
reg clk=0;
reg ra=0,raNBA=0;
reg rb=0, rbNBA=0;
reg rc=0, rcNBA=0;
reg rd=0, rdNBA=0;
reg re=0, reNBA=0;
wire [2:0] floor;

always @* {raNBA,rbNBA,rcNBA,rdNBA,reNBA}<={ra,rb,rc,rd,re};
lift5 KABALI (clk,rst,raNBA,rbNBA,rcNBA,rdNBA,reNBA,floor);

initial
	begin
	#2;rst=0;
	repeat(5) @(posedge clk);
	repeat(20)
		begin
			{ra,rb,rc,rd,re}=$random;
			@(posedge clk);
			{ra,rb,rc,rd,re}=5'b00000;
			repeat(5) @(posedge clk);
		end
		
	$finish;
	end

always #5 clk=!clk;
enum {A,B,C,D,E} tb_floor;
enum {UP,DOWN} tb_dir;
always @*
begin
	case(floor)
	0: tb_floor=A;
	1: tb_floor=B;
	2: tb_floor=C;
	3: tb_floor=D;
	4: tb_floor=E;
	endcase
end

always @* 
begin
	case(tb.KABALI.dir)
	0: tb_dir=UP;
	1: tb_dir=DOWN;
	endcase
end

endmodule


