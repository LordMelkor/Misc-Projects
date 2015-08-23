function postMap()
{
	function getMax(arr)
	{
		var max = arr[0];
		var maxIndex = 0;
		for (var i = 1; i < arr.length; i++)
		{
			if (arr[i] > max)
			{
				maxIndex = i;
				max = arr[i];
			}
		}
		return [max,maxIndex];
	}
	
	var key = {userid: this._id.userid, bzid: this._id.bzid};
	if (this.value.count>15000)
	{
		var mx = getMax(this.value.hours);
		emit(key, {views: mx[0], peak: mx[1], hours:this.value.hours});
	}
	else
	{
		return;
	}
}