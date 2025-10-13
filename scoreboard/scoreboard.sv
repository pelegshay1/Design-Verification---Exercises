module scoreboard (	);

int count_db [string];

task automatic add_item(input string name);
	if (count_db.exists(name)) // If the key exist in array , add 1 to score
		count_db[name]++;
    else
   		count_db[name] = 1; // If the key doesnt exist in array set the score to 1 
endtask : add_item

function automatic int get_count(input string name);  //return the score of a specific key
	return count_db[name];
endfunction : get_count


endmodule : scoreboard
