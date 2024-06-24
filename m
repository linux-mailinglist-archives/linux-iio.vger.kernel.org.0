Return-Path: <linux-iio+bounces-6793-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79133914279
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 08:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3440C280F0B
	for <lists+linux-iio@lfdr.de>; Mon, 24 Jun 2024 06:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DF0208B6;
	Mon, 24 Jun 2024 06:04:28 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from www571.your-server.de (www571.your-server.de [78.46.3.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD7219E1;
	Mon, 24 Jun 2024 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.3.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719209068; cv=none; b=gHgVjBQ0z8JW78MykfVqpzZe9aCjGwH8SUlrpqTCy9XlUfAzsg+0wwTyJuOevDXWPWYbwJyOJjrtvk3c24af6EPmRXxDbMca8ppf2Iax836PQPYBAPOYFJTykoV8ULY+hvi6xvUtIFeItHUJu5QYsuLckixE9KiKfAjS88wt/fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719209068; c=relaxed/simple;
	bh=U3Og0bqvlzhjzeHnpaabTo+HkClNM1LvbFB1gNzMx0I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hmzsRJiPVrGXdo1ACJsry9bymQyxWheBBiKVRfrQysYuC5FFZa/NTqUIF4kl1rw9Fn/9L1BHftObYox+qp0mw1b8jrA4z83UUpeMDfXE7z4D0gi2IVEjGEqlQ9lLowetnSc9l+FyIchjNoZMdAJ4uzfufeoh1Il+Dh4PDHIXLpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de; spf=pass smtp.mailfrom=it-klinger.de; arc=none smtp.client-ip=78.46.3.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-klinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-klinger.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www571.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcoQ-000N3v-1z;
	Mon, 24 Jun 2024 08:04:22 +0200
Received: from [31.220.119.164] (helo=mail.your-server.de)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ak@it-klinger.de>)
	id 1sLcoQ-0005xR-2g;
	Mon, 24 Jun 2024 08:04:22 +0200
Date: Mon, 24 Jun 2024 08:04:20 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] iio: adc: hx711: remove hx711_remove()
Message-ID: <ZnkMZIKpmn8HOKN8@mail.your-server.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="REpzHSWIu3PPM3Ri"
Content-Disposition: inline
In-Reply-To: <20240621-iio-regulator-refactor-round-2-v1-3-49e50cd0b99a@baylibre.com>
X-Authenticated-Sender: ak@it-klinger.de
X-Virus-Scanned: Clear (ClamAV 1.0.3/27315/Sun Jun 23 10:23:58 2024)


--REpzHSWIu3PPM3Ri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2024-06-21 at 22:11 +0000, David Lechner wrote:
> By using a few more devm_ functions, we can remove the hx711_remove()
> function in the hx711 driver.
>=20
> platform_set_drvdata() is also removed since there are no more
> callers of platform_get_drvdata().
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Reviewed-by: Andreas Klinger <ak@it-klinger.de>

--=20

--REpzHSWIu3PPM3Ri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEE7/NrAFtB/Pj7rTUyyHDM+xwPAVEFAmZ5DGQACgkQyHDM+xwP
AVGUzAv/R+Kp1tZQvHmNgF6j1nIL6ZcD2WW4RaDqTbEY9EllGV7UJ4bLmF4ZbPvX
dpsNoyNdv9RPd8vOArWgwy8u6nU+LksOKqUB+flj0mkIR92SOgcOSr/KfzqsleaM
zrPw0h8Ez14MYi/DAkw53oiAjekA7dFiUlyaaHCjAenRYXbyR2HJhfAMHCnn9/q8
5C/hafg5YF3DgvgBcp5P4UoVaeqJX7SCa3RCUfpjFhicuxljjqFEamhfA72OeIT8
20XJL0e/VDWKU+xXU8lr8k8sQb07G4jY1c7brLbQxDj2Svy9Mts2FE5k2QgaVNTo
yegqb8E0KvSwOO2vBT+Sp4axHfKwReD+ZJuZtlWY9DMptYh0if7Rnuc8Xu0QlJkI
Q8UrrW9t4fxtiXZprKzExSt0alge1KjZT9TswcM4xNMiJ71nYh0vuyJkF3L0rzFZ
NSZHw7VRTK1dFRFoAJXfElaWIP5fnv9hcWHdRo2CuEoj2dm6IYH0lvKlRjWanUzz
fEC7SshG
=d+/F
-----END PGP SIGNATURE-----

--REpzHSWIu3PPM3Ri--

