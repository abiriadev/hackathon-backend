/**
 * Handler for Account
 *
 */


class Account {
	public static index (req: IRequest, res: IResponse): void {
		return res.render('pages/dashboard', {
			title: 'Home'
		});
	}
}

export default Account;
