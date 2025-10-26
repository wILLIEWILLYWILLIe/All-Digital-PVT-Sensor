module stageUnit #(parameter WIDTH = 32) (
    input      [WIDTH-1:0] in_data1, 
    input      [WIDTH-1:0] in_data2,     
    output      [WIDTH-1 :0] out_data
    
);
    wire [WIDTH-1:0] in_a;
    wire [WIDTH-1:0] in_b;
    wire [WIDTH-1:0] result;

    assign in_a = in_data1;
    assign in_b = in_data2;
    assign out_data = result;
    
    //--------------------32 paths
    //-----------------------inv------------------------
    //path 1 (fast one)
    invChain #(.LENGTH (9), .DRIVER_L (1)) u_invChain_0 (
        .in_data (in_a[0]),
        .out_data (result[0])
    );
    //path 2
    wire t1;
    invChain #(.LENGTH (9), .DRIVER_L (1)) u_invChain_1 (
        .in_data (in_a[1]),
        .out_data (t1)
    );
    invChain #(.LENGTH (2), .DRIVER_L (2)) u_invChain_2 (
        .in_data (t1),
        .out_data (result[1])
    );
    //path 3
    wire t2,t3;
    invChain #(.LENGTH (9), .DRIVER_L (1)) u_invChain_3 (
        .in_data (in_a[2]),
        .out_data (t2)
    );
    invChain #(.LENGTH (2), .DRIVER_L (4)) u_invChain_4 (
        .in_data (t2),
        .out_data (t3)
    );
    invChain #(.LENGTH (2), .DRIVER_L (16)) u_invChain_5 (
        .in_data (t2),
        .out_data (result[2])
    );
    //path 4
    invChain #(.LENGTH (9), .DRIVER_L (8)) u_invChain_6 (
        .in_data (in_a[3]),
        .out_data (result[3])
    );
    //-----------------------nand------------------------
    //path 5
    nandChain #(.LENGTH(8), .DRIVER_L(1)) u_nandChain_0 (
        .in_data (in_a[4]),
        .in_ctrl (in_b[20]),
        .out_data (result[4])
    );
    //path 6
    nandChain #(.LENGTH(7), .DRIVER_L(2)) u_nandChain_1 (
        .in_data (in_a[5]),
        .in_ctrl (in_b[21]),
        .out_data (result[5])
    );   
    //path 7
    wire t4;
    nandChain #(.LENGTH(5), .DRIVER_L(1)) u_nandChain_2 (
        .in_data (in_a[6]),
        .in_ctrl (in_b[22]),
        .out_data (t4)
    );    
    nandChain #(.LENGTH(2), .DRIVER_L(2)) u_nandChain_3 (
        .in_data (t4),
        .in_ctrl (in_b[22]),
        .out_data (result[6])
    );   
    //path 8
    wire t5,t6;
    nandChain #(.LENGTH(10), .DRIVER_L(1)) u_nandChain_4 (
        .in_data (in_a[7]),
        .in_ctrl (in_b[23]),
        .out_data (t5)
    );    
    nandChain #(.LENGTH(2), .DRIVER_L(2)) u_nandChain_5 (
        .in_data (t5),
        .in_ctrl (in_b[23]),
        .out_data (t6)
    );   
    nandChain #(.LENGTH(1), .DRIVER_L(4)) u_nandChain_6 (
        .in_data (t6),
        .in_ctrl (in_b[23]),
        .out_data (result[7])
    );   
    //path 9
    nandChain #(.LENGTH(6), .DRIVER_L(4)) u_nandChain_7 (
        .in_data (in_a[8]),
        .in_ctrl (in_b[24]),
        .out_data (result[8])
    );   
    //-----------------------nor------------------------
    //path 10
    norChain #(.LENGTH(8), .DRIVER_L(1)) u_norChain_0 (
        .in_data (in_a[9]),
        .in_ctrl (in_b[25]),
        .out_data (result[9])
    );
    //path 11
    norChain #(.LENGTH(7), .DRIVER_L(2)) u_norChain_1 (
        .in_data (in_a[10]),
        .in_ctrl (in_b[26]),
        .out_data (result[10])
    );   
    //path 12
    wire t7;
    norChain #(.LENGTH(5), .DRIVER_L(1)) u_norChain_2 (
        .in_data (in_a[11]),
        .in_ctrl (in_b[27]),
        .out_data (t7)
    );    
    norChain #(.LENGTH(2), .DRIVER_L(2)) u_norChain_3 (
        .in_data (t7),
        .in_ctrl (in_b[27]),
        .out_data (result[11])
    );   
    //path 13
    wire t8,t9;
    norChain #(.LENGTH(10), .DRIVER_L(1)) u_norChain_4 (
        .in_data (in_a[12]),
        .in_ctrl (in_b[28]),
        .out_data (t8)
    );    
    norChain #(.LENGTH(2), .DRIVER_L(2)) u_norChain_5 (
        .in_data (t8),
        .in_ctrl (in_b[28]),
        .out_data (t9)
    );   
    norChain #(.LENGTH(1), .DRIVER_L(4)) u_norChain_6 (
        .in_data (t9),
        .in_ctrl (in_b[28]),
        .out_data (result[12])
    );   
    //path 14
    norChain #(.LENGTH(6), .DRIVER_L(4)) u_norChain_7 (
        .in_data (in_a[13]),
        .in_ctrl (in_b[29]),
        .out_data (result[13]
        )
    );   
    //-------------------xor----------------------------
    //path 15        
    xorChain #(.LENGTH(10  ), .DRIVER_L(1  )) u_xorChain_0(
        .in_data  	(in_a[14]   ),
        .in_ctrl  	(in_b[30]   ),
        .out_data 	(result[14]  )
    );
    //path 16        
    xorChain #(.LENGTH(8  ), .DRIVER_L(2  )) u_xorChain_1(
        .in_data  	(in_a[15]   ),
        .in_ctrl  	(in_b[31]   ),
        .out_data 	(result[15]  )
    );
    //path 17
    wire t10;        
    xorChain #(.LENGTH(4  ), .DRIVER_L(1  )) u_xorChain_2(
        .in_data  	(in_a[16]   ),
        .in_ctrl  	(in_b[0]   ),
        .out_data 	(t10 )
    );       
    xorChain #(.LENGTH(4  ), .DRIVER_L(2  )) u_xorChain_3(
        .in_data  	(t10   ),
        .in_ctrl  	(in_b[0]   ),
        .out_data 	(result[16]  )
    );
    //path 18
    wire t11;        
    xorChain #(.LENGTH(6  ), .DRIVER_L(1  )) u_xorChain_4(
        .in_data  	(in_a[17]   ),
        .in_ctrl  	(in_b[1]   ),
        .out_data 	(t11 )
    );       
    xorChain #(.LENGTH(2  ), .DRIVER_L(2  )) u_xorChain_5(
        .in_data  	(t11   ),
        .in_ctrl  	(in_b[1]   ),
        .out_data 	(result[17]  )
    );
    //--------------------nand_nor------------------------
    //path 19
    nandNorChain #(.LENGTH(7  ), .DRIVER_L(1  )) u_nandNorChain_0(
        .in_data   	(in_a[18]    ),
        .in_data_b 	(in_b[2]  ),
        .out_data  	(result[18]  )
    );
    //path 20
    nandNorChain #(.LENGTH(5  ), .DRIVER_L(2  )) u_nandNorChain_1(
        .in_data   	(in_a[19]    ),
        .in_data_b 	(in_b[3]  ),
        .out_data  	(result[19]  )
    );
    //path 21
    nandNorChain #(.LENGTH(5  ), .DRIVER_L(4  )) u_nandNorChain_2(
        .in_data   	(in_a[20]    ),
        .in_data_b 	(in_b[4]  ),
        .out_data  	(result[20]  )
    );
    //path 22
    wire t12;
    nandChain #(.LENGTH(6), .DRIVER_L(1)) u_nandChain_8 (
        .in_data (in_a[21]),
        .in_ctrl (in_b[5]),
        .out_data (t12)
    );   
    norChain #(.LENGTH(6), .DRIVER_L(1)) u_norChain_8 (
        .in_data (t12),
        .in_ctrl (in_b[5]),
        .out_data (result[21])
    );    
    //path 23
    wire t13;
    nandChain #(.LENGTH(6), .DRIVER_L(2)) u_nandChain_9 (
        .in_data (in_a[22]),
        .in_ctrl (in_b[6]),
        .out_data (t13)
    );   
    norChain #(.LENGTH(6), .DRIVER_L(2)) u_norChain_9 (
        .in_data (t13),
        .in_ctrl (in_b[6]),
        .out_data (result[22])
    );    
    //path 24
    wire t14,t15;
    nandChain #(.LENGTH(6), .DRIVER_L(2)) u_nandChain_10 (
        .in_data (in_a[23]),
        .in_ctrl (in_b[7]),
        .out_data (t14)
    );   
    norChain #(.LENGTH(5), .DRIVER_L(1)) u_norChain_10 (
        .in_data (t14),
        .in_ctrl (in_b[7]),
        .out_data (t15)
    );     
    invChain #(.LENGTH (3), .DRIVER_L (1)) u_invChain_7 (
        .in_data (t15),
        .out_data (result[23])
    );
    //path 25
    muxInvChain #(.LENGTH(4  ), .DRIVER_L(1  )) u_muxInvChain_0(
        .in_data   	(in_a[24]    ),
        .in_data_b 	(in_b[8]  ),
        .in_ctrl   	(in_a[24]    ),
        .out_data  	(result[24]   )
    );
    //path 26
    muxInvChain #(.LENGTH(8  ), .DRIVER_L(1  )) u_muxInvChain_1(
        .in_data   	(in_a[25]    ),
        .in_data_b 	(in_b[9]  ),
        .in_ctrl   	(in_a[25]    ),
        .out_data  	(result[25]   )
    );
    //path 27
    muxInvChain #(.LENGTH(4  ), .DRIVER_L(2  )) u_muxInvChain_2(
        .in_data   	(in_a[26]    ),
        .in_data_b 	(in_b[10]  ),
        .in_ctrl   	(in_a[26]    ),
        .out_data  	(result[26]   )
    );
    //path 28
    muxInvChain #(.LENGTH(8  ), .DRIVER_L(2  )) u_muxInvChain_3(
        .in_data   	(in_a[27]    ),
        .in_data_b 	(in_b[11]  ),
        .in_ctrl   	(in_a[27]    ),
        .out_data  	(result[27]   )
    );
    //path 29
    wire t16;
    muxInvChain #(.LENGTH(7  ), .DRIVER_L(2  )) u_muxInvChain_4(
        .in_data   	(in_a[28]    ),
        .in_data_b 	(in_b[12]  ),
        .in_ctrl   	(in_a[28]    ),
        .out_data  	(t16   )
    );
    invChain #(.LENGTH (3), .DRIVER_L (2)) u_invChain_8 (
        .in_data (t16),
        .out_data (result[28])
    );  
    //--------------------supplement--------------------------  
    //path 30
    invChain #(.LENGTH (7), .DRIVER_L (32)) u_invChain_9 (
        .in_data (in_a[29]),
        .out_data (result[29])
    );    
    //path 31
    invChain #(.LENGTH (9), .DRIVER_L (16)) u_invChain_10 (
        .in_data (in_a[30]),
        .out_data (result[30])
    ); 
    //path 32 lowest path delay
    wire t17,t18,t19;
    norChain #(.LENGTH(5), .DRIVER_L(1)) u_norChain_11 (
        .in_data (in_a[31]),
        .in_ctrl (in_b[15]),
        .out_data (t17)
    );        
    xorChain #(.LENGTH(5  ), .DRIVER_L(1  )) u_xorChain_6(
        .in_data  	(t17   ),
        .in_ctrl  	(in_b[16]   ),
        .out_data 	(t18  )
    );    
    muxInvChain #(.LENGTH(4  ), .DRIVER_L(1  )) u_muxInvChain_5(
        .in_data   	(t18    ),
        .in_data_b 	(in_b[17]  ),
        .in_ctrl   	(in_b[18]    ),
        .out_data  	(t19   )
    );
    invChain #(.LENGTH (1), .DRIVER_L (4)) u_invChain_11 (
        .in_data (t19),
        .out_data (result[31])
    );      
endmodule
/////////////////////////////////////////////////////////////////////////////////////
//------------------------------Chains----------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////
module invChain #(
    parameter LENGTH = 8,
    parameter DRIVER_L =1
)(
    input  in_data,
    output out_data
);
    wire [LENGTH:0] arr_t;
    assign arr_t[0] = in_data;

    genvar i;
    generate
    case (DRIVER_L)
        2: begin: drv2
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X2
                INV_X2 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end
        end 
        4: begin: drv4
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X4
                INV_X4 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end
        end 
        8: begin: drv8
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X8
                INV_X8 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end
        end 
        16: begin: drv16
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X16
                INV_X16 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end
        end 
        32: begin: drv32
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X32
                INV_X32 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end
        end 
        default: begin : drv1
            for (i =0 ;i<LENGTH ; i=i+1) begin : invPath
                //output declaration of module INV_X1
                INV_X1 g1(
                    .A  	(arr_t[i]),
                    .ZN 	(arr_t[i+1])
                );
            end                
        end
    endcase
    endgenerate

    assign out_data = arr_t[LENGTH];
    
endmodule

module nandChain #(
    parameter LENGTH = 8,
    parameter DRIVER_L = 4
) (
input in_data,
input in_ctrl,
output out_data
);
    wire [LENGTH:0] arr_t;
    wire [1:0] b_t;

    assign arr_t[0] = in_data;
    assign b_t = {~in_ctrl,in_ctrl};

    genvar i;
    generate
    case (DRIVER_L)
        2: begin: drv2
            for (i = 0; i<LENGTH; i=i+1) begin : nandPath
                // output declaration of module NAND2_X2
                NAND2_X2 g1(
                    .A1 	(arr_t[i] ),
                    .A2 	(b_t[i%2] ),
                    .ZN 	(arr_t[i+1]  )
                );
            end
        end 
        4: begin: drv4
            for (i = 0; i<LENGTH; i=i+1) begin : nandPath
                // output declaration of module NAND2_X4
                NAND2_X4 g1(
                    .A1 	(arr_t[i] ),
                    .A2 	(b_t[i%2] ),
                    .ZN 	(arr_t[i+1]  )
                );
            end
        end 
        default: begin : drv1
            for (i = 0; i<LENGTH; i=i+1) begin : nandPath
                // output declaration of module NAND2_X1
                NAND2_X1 g1(
                    .A1 	(arr_t[i] ),
                    .A2 	(b_t[i%2] ),
                    .ZN 	(arr_t[i+1]  )
                );
            end                
        end
    endcase
    endgenerate

    assign out_data = arr_t[LENGTH];
endmodule

module norChain #(
    parameter LENGTH = 8,
    parameter DRIVER_L = 1
) (
    input in_data,
    input in_ctrl,
    output out_data
);
    wire  [LENGTH:0] arr_t;
    wire  [1:0] b_t;

    assign arr_t[0] = in_data;
    assign b_t = {~in_ctrl,in_ctrl};

    genvar i;
    generate
    case (DRIVER_L)
        2 : begin : drv2
            for (i = 0; i<LENGTH; i=i+1) begin : norPath
                // output declaration of module NOR2_X2
                NOR2_X2 g1(
                    .A1 	(arr_t[i]  ),
                    .A2 	(b_t[i%2]  ),
                    .ZN 	(arr_t[i+1]  )
                );
            end        
        end
        4 : begin : drv4
            for (i = 0; i<LENGTH; i=i+1) begin : norPath
                // output declaration of module NOR2_X4
                NOR2_X4 g1(
                    .A1 	(arr_t[i]  ),
                    .A2 	(b_t[i%2]  ),
                    .ZN 	(arr_t[i+1]  )
                );
            end            
        end
        default : begin : drv1
            for (i = 0; i<LENGTH; i=i+1) begin : norPath
                // output declaration of module NOR2_X1
                NOR2_X1 g1(
                    .A1 	(arr_t[i]  ),
                    .A2 	(b_t[i%2]  ),
                    .ZN 	(arr_t[i+1]  )
                );
        
            end  
        end
    endcase
    endgenerate

    assign out_data = arr_t[LENGTH];
endmodule

module xorChain #(
    parameter LENGTH = 8,
    parameter DRIVER_L = 1
) (
    input in_data,
    input in_ctrl,
    output out_data
);
    wire  [LENGTH:0] arr_t;
    wire  [1:0] b_t;

    assign arr_t[0] = in_data;
    assign b_t = {~in_ctrl,in_ctrl};

    genvar i;
    generate
    if (DRIVER_L==2) begin : drv2
        for (i = 0; i<LENGTH; i=i+1) begin : xorPath
            // output declaration of module XOR2_X2      
            XOR2_X2 g1(
                .A 	(arr_t[i] ),
                .B 	(b_t[i%2] ),
                .Z 	(arr_t[i+1]  )
            );
        end          
    end
    else begin : drv1
        for (i = 0; i<LENGTH; i=i+1) begin : xorPath
            // output declaration of module XOR2_X1      
            XOR2_X1 g1(
                .A 	(arr_t[i] ),
                .B 	(b_t[i%2] ),
                .Z 	(arr_t[i+1]  )
            );
        end          
    end
    endgenerate

    assign out_data = arr_t[LENGTH];
endmodule

module muxInvChain #(
    parameter LENGTH = 4,
    parameter DRIVER_L = 1
) (
    input in_data,
    input in_data_b,
    input in_ctrl,
    output out_data
);
    wire  [LENGTH:0] arr_t;
    wire  [1:0] b_t, ctrl_t;

    assign arr_t[0] = in_data;
    assign b_t = {~in_data_b,in_data_b};
    assign ctrl_t = {~in_ctrl,in_ctrl};

    genvar i;
    generate
    if (DRIVER_L==2) begin : drv2
        for (i = 0; i<LENGTH; i=i+1) begin : muxInvPath
            wire t;
            INV_X2 g1(.A(arr_t[i]), .ZN(t));
            MUX2_X1 ut_mux(.A(t), .B(b_t[i%2]), .S(ctrl_t[i%2]), .Z(arr_t[i+1]));
        end          
    end
    else begin : drv1
        for (i = 0; i<LENGTH; i=i+1) begin : muxInvPath
            wire t;
            INV_X1 g1(.A(arr_t[i]), .ZN(t));
            MUX2_X1 ut_mux(.A(t), .B(b_t[i%2]), .S(ctrl_t[i%2]), .Z(arr_t[i+1]));
        end         
    end
    endgenerate

    assign out_data = arr_t[LENGTH];
endmodule

module nandNorChain #(
    parameter LENGTH = 4,
    parameter DRIVER_L = 1
) (
    input in_data,
    input in_data_b,
    output out_data
);
    wire  [LENGTH:0] arr_t;
    wire  [1:0] b_t;

    assign arr_t[0] = in_data;
    assign b_t = {~in_data_b,in_data_b};

    genvar i;
    generate
    case (DRIVER_L)
        2 : begin : drv2
            for (i = 0; i<LENGTH; i=i+1) begin : nandNorPath
                wire t;
                NAND2_X2 ut_nand(.A1(arr_t[i] ), .A2(b_t[0] ),.ZN(t));
                NOR2_X2 ut_nor( .A1(t ), .A2(b_t[1] ),.ZN(arr_t[i+1] ));
            end        
        end
        4 : begin : drv4
            for (i = 0; i<LENGTH; i=i+1) begin : nandNorPath
                wire t;
                NAND2_X4 ut_nand(.A1(arr_t[i] ), .A2(b_t[0] ),.ZN(t));
                NOR2_X4 ut_nor( .A1(t ), .A2(b_t[1] ),.ZN(arr_t[i+1] ));
            end            
        end
        default : begin : drv1
            for (i = 0; i<LENGTH; i=i+1) begin : nandNorPath
                wire t;
                NAND2_X1 ut_nand(.A1(arr_t[i] ), .A2(b_t[0] ),.ZN(t));
                NOR2_X1 ut_nor( .A1(t ), .A2(b_t[1] ),.ZN(arr_t[i+1] ));
            end    
        end
    endcase
    endgenerate

    assign out_data = arr_t[LENGTH];
endmodule