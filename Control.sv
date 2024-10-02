//Two-always example for state machine

module control (input  logic Clk, Reset, Execute, Mval,
                output logic Executing, Shift_En, Yes_Add, Yes_Sub, Load_B);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
   // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	 // Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0] {LoadReset, Start, ResetAX, Add0, Shift0, Add1, Shift1, Add2, Shift2, Add3, Shift3, Add4, Shift4, Add5, Shift5, Add6, Shift6, SubtractSt, last_shift, Rest}   curr_state, next_state; 



	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)  
    begin
        if (Reset)
            curr_state <= LoadReset;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            LoadReset : next_state = Start;
            
            Start :    if (Execute)
                       next_state = ResetAX;
            ResetAX :    next_state = Add0;
            Add0:    
                next_state = Shift0;
            Shift0: 
                next_state = Add1;
            Add1:    
                next_state = Shift1;
            Shift1: 
                next_state = Add2;
            Add2:    
                next_state = Shift2;
            Shift2: 
                next_state = Add3;
            Add3:    
                next_state = Shift3;
            Shift3: 
                next_state = Add4;
            Add4:    
                next_state = Shift4;
            Shift4: 
                next_state = Add5;
            Add5:    
                next_state = Shift5;
            Shift5: 
                next_state = Add6;
            Add6:    
                next_state = Shift6;
            Shift6: 
                next_state = SubtractSt;
            SubtractSt: 
                next_state = last_shift;
            last_shift: 
                next_state = Rest;
            Rest:
                if (~Execute)  
                next_state = Start;
        endcase
   
		  // Assign outputs based on 'state'
        case (curr_state) 
        

            LoadReset : 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;
                    Load_B = 1'b1;
                end
            Start :    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;
                    Load_B = 1'b0;
                end
            ResetAX :    //a = cur switches
                begin
                    Executing = 1'b0;
                    Shift_En = 1'b0;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;
                    Load_B = 1'b0;
                end
            Add0:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                 
                end
            Shift0: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                   
                end
            Add1:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Shift1: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                    
                end
            Add2:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Shift2: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Add3:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                    
                end
            Shift3: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Add4:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Shift4: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                    
                end
            Add5:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                    
                end
            Shift5: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                   
                end
            Add6:    
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = Mval;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                    
                end
            Shift6: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                   
                end
            SubtractSt: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = 1'b0;
                    Yes_Sub = Mval;   
                    Load_B = 1'b0;  
                end
            last_shift: 
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b1;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end
            Rest:
                begin
                    Executing = 1'b1;
                    Shift_En = 1'b0;
                    Yes_Add = 1'b0;
                    Yes_Sub = 1'b0;   
                    Load_B = 1'b0;                     
                end

        endcase
    end

endmodule