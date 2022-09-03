/**
 * Handle all your social auth routesß
 *
 */

	public static googleCallback(req, res): any {
		return res.redirect('/account');
	}
}

export default Social;
