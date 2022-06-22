#include <tofino/intrinsic_metadata.p4>
#include "tofino/stateful_alu_blackbox.p4"

/* Declare Header */
header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header ethernet_t ethernet;

/* // XXX: legacy code below
header_type ipv4_t {
    fields {
        // TODO: Have a hard limit on 5 fields for now. Ensure this in the tofino code generator.
        pkt_0 : 32 (signed);
        pkt_1 : 32 (signed);
        pkt_2 : 32 (signed);
        pkt_3 : 32 (signed);
        pkt_4 : 32 (signed);
    }
}*/

/* ruijief: added support for customized PHV container fields. */
header_type ipv4_t {
    fields {
 
        p__br_tmp5 : 32 (signed);   
        p_state_001 : 32 (signed);   
        p_pkt_0 : 32 (signed);  
    }
}

header ipv4_t ipv4;

/* Declare Parser */
parser start {
	return select(current(96,16)){
		0x0800: parse_ethernet;
	}
}

parser parse_ethernet {
    extract(ethernet);
    return select(latest.etherType) {
        /** Fill Whatever ***/
        0x0800     : parse_ipv4;
        default: ingress;
    }
}
parser parse_ipv4 {
    extract(ipv4);
    return ingress;
}

// TODO: Derive MAX_SIZE from Domino program.
#define MAX_SIZE 10

register reg_0 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
}

register reg_1 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
}

register reg_2 {
    width : 64;
    instance_count : MAX_SIZE;
    attributes : signed;
}



  
    
// Stateful ALU blackbox
blackbox stateful_alu test_stateful_alu_0_0_blackbox {
    
    
    reg                       : reg_0;
    condition_lo              : (((0-ipv4.p_pkt_0)+alu_lo)+1)>0;
    condition_hi              : (((0-ipv4.p_pkt_0)+alu_hi)+2)>0;
    update_lo_1_predicate     : (condition_hi) and ( not (condition_lo));
    update_lo_1_value         : (ipv4.p_pkt_0)+(alu_lo);
    update_lo_2_predicate     :  not ((condition_hi) or (condition_lo));
    update_lo_2_value         : (ipv4.p_pkt_0)+(0);
    update_hi_1_predicate     : false;
    update_hi_1_value         : (7);
    update_hi_2_predicate     : false;
    update_hi_2_value         : (31)+(25);
    output_predicate          : 1;
    output_value              : 0;
    output_dst                : ipv4.p_state_001;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;

    
}

// Stateful ALU Action
action test_stateful_alu_0_0_action () {
    test_stateful_alu_0_0_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}

// Stateful ALU table
@pragma ignore_table_dependency test_stateful_alu_1_0_table
@pragma stage 0
table test_stateful_alu_0_0_table {
    actions {
        test_stateful_alu_0_0_action;
    }
    default_action: test_stateful_alu_0_0_action;
}

  
    
  
    
// Stateful ALU blackbox
blackbox stateful_alu test_stateful_alu_0_2_blackbox {
    
    
    reg                       : reg_2;
    condition_lo              : ((ipv4.p_pkt_0-alu_lo)+1)>0;
    condition_hi              : alu_lo==0;
    update_lo_1_predicate     : false;
    update_lo_1_value         : (20)-(31);
    update_lo_2_predicate     : (condition_hi) or (condition_lo);
    update_lo_2_value         : (ipv4.p_pkt_0)-(alu_hi);
    update_hi_1_predicate     :  not ((condition_hi) or (condition_lo));
    update_hi_1_value         : 1;
    update_hi_2_predicate     : false;
    update_hi_2_value         : (1)-(ipv4.p_pkt_0);
    output_predicate          : 1;
    output_value              : 0;
    output_dst                : ipv4.p__br_tmp5;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;

    
}

// Stateful ALU Action
action test_stateful_alu_0_2_action () {
    test_stateful_alu_0_2_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}

// Stateful ALU table
@pragma ignore_table_dependency test_stateful_alu_1_2_table
@pragma stage 0
table test_stateful_alu_0_2_table {
    actions {
        test_stateful_alu_0_2_action;
    }
    default_action: test_stateful_alu_0_2_action;
}

  

  
    
  
    
// Stateful ALU blackbox
blackbox stateful_alu test_stateful_alu_1_1_blackbox {
    
    
    reg                       : reg_1;
    condition_lo              : ((0-ipv4.p__br_tmp5)+alu_hi)==0;
    condition_hi              : ((0-ipv4.p__br_tmp5)-alu_lo)>0;
    update_lo_1_predicate     :  not ((condition_hi) or (condition_lo));
    update_lo_1_value         : (1)+(alu_lo);
    update_lo_2_predicate     : false;
    update_lo_2_value         : (ipv4.p__br_tmp5)+(18);
    update_hi_1_predicate     : (condition_hi) and ( not (condition_lo));
    update_hi_1_value         : (29)-(ipv4.p__br_tmp5);
    update_hi_2_predicate     : (condition_hi) and ( not (condition_lo));
    update_hi_2_value         : (alu_hi)-(1);
    output_predicate          : 1;
    output_value              : alu_hi;
    output_dst                : 0;
    
    initial_register_lo_value : 0; // Magic value TODO: needs to be changed.
    initial_register_hi_value : 0;

    
}

// Stateful ALU Action
action test_stateful_alu_1_1_action () {
    test_stateful_alu_1_1_blackbox.execute_stateful_alu(0);
    // TODO: Replace 0 with appropriate value for array-based registers. The
    // appropriate value can be determined by parsing the .c file using the
    // Domino compiler.
}

// Stateful ALU table
@pragma ignore_table_dependency test_stateful_alu_1_1_table
@pragma stage 1
table test_stateful_alu_1_1_table {
    actions {
        test_stateful_alu_1_1_action;
    }
    default_action: test_stateful_alu_1_1_action;
}

  
    
  



  

  


// Required: mac_forward table for forwarding to switch CPU.
action set_egr(egress_spec) {
    modify_field(ig_intr_md_for_tm.ucast_egress_port, egress_spec);
}
table mac_forward {
    reads {
        ethernet.dstAddr : exact;
    }
    actions {
        set_egr;
    }
    size:1;
}

control ingress {
    // Call all the required ALUs.
    
      
      
        
          apply(test_stateful_alu_0_0_table);
        
      
        
      
        
          apply(test_stateful_alu_0_2_table);
        
      
    
      
      
        
      
        
          apply(test_stateful_alu_1_1_table);
        
      
        
      
    
    // MAC Forwarding by default
    apply(mac_forward);
}

control egress {

}