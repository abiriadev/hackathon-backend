/**
 * Define the API base url
 *
 */


class Home {
	public static index(req, res, next): any {
		return res.json({
			message: Locals.config().name
		});
	}
}

export default Home;
