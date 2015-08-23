function allPostMap()
{
	var key = {bzid: this.bzid};
	emit(key, {count: this.total, hours: this.hours});
}