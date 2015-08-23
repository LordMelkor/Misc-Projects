function countReduce(key, values)
{
	var sum = 0;
	var hourSum = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];
	for (var i =0; i < values.length; i++)
	{
		sum+=values[i].count;
		hourSum = hourSum.map(function(num,idx) {
			return num + values[i].hours[idx];
		});
	}
	return {count: sum, hours: hourSum};
};