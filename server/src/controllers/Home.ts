/**
 * Handler for Home
 *
 */


class Home {
	public static index (req: IRequest, res: IResponse, next): void {
		return res.render('pages/home', {
			title: 'Home'
		});
	}
}

export default Home;
