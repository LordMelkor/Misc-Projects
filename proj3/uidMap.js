function uidMap()
{
	var key = {userid: this.userid};
	emit(key, {count: this.total});
}