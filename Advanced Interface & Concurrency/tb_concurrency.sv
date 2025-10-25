
`include "driver.sv"
`include "monitor.sv"
`include "checker.sv"

module tb_concurrency (
);

    logic clk=0;
    logic reset;
    always #5 clk = ~clk; 			 // Clock Generation

    // Interface and DUT Instantiation
    
    // Instantiate the bus interface

    bus_if bus_inst(.clk(clk)); 

    // Instantiate the DUT slave module

    dut_slave dut (.clk(clk), .reset(reset), .bus(bus_inst.slave));

    // 3. Test Components Declaration
    // Assumes your classes are named BusDriver , BusMonitor , monitor and mychecker

    Busdriver mydriver_1;  // Driver #1
    Busdriver mydriver_2;  //Driver #2
    monitor mymonitor;     //monitor
    mychecker checkme;		//checker

initial begin
	semaphore access_limit;
	mailbox # (transaction) mail_box;

	mail_box = new(2);					//create 2 slots in mailbox
	
	access_limit= new (1);				// create one key only

	mydriver_1 = new(bus_inst.driver,access_limit);  //Driver #1 object

	mydriver_2 = new(bus_inst.driver,access_limit);  //Driver #2 object

	mymonitor = new (bus_inst.monitor,mail_box);  //monitor object

	checkme = new (mail_box);					//chekcer object

	fork
		 // Monitor runs continuously in the background
        mymonitor.run(); 
         // Driver runs the transaction (Driver must complete the bus protocol)
        checkme.run();
	join_none 

	fork
		mydriver_1.run(1);		//start driver #1 run with id=1
		mydriver_2.run(2);		//start driver #2 run with id=2
	join

	#10; // let the proccess in mychecker.run finish 2 transaction fully before assertion 

	assert (checkme.count ==2 );
	$display("TestBench finished successfuly after %d transactions",checkme.count);
	$finish;
end


endmodule : tb_concurrency
