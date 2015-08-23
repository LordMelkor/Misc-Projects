function countReduce(key, values)
{
	return {views: values[0].views, peak: values[0].peak, hours: values[0].hours};
};