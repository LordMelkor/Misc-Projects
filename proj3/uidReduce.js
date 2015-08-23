function countReduce(key, values)
{
	var sum = 0;
	for (var i =0; i < values.length; i++)
	{
		sum+=values[i].count;
	}
	return {count: sum};
};