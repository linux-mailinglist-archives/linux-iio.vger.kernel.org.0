Return-Path: <linux-iio+bounces-612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5DA803EE2
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 21:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD941F21195
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8426033095;
	Mon,  4 Dec 2023 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="MD8ZZlFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (unknown [IPv6:2a01:7e01:e001:1d1::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55EBC4;
	Mon,  4 Dec 2023 11:59:52 -0800 (PST)
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2EBD128EE6F;
	Mon,  4 Dec 2023 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1701719991;
	bh=+nDCKIJsNn3sdyyepy9COQh7EZ5oRjjTsJna287/22o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MD8ZZlFKvtWImQs7JJwrKccj+k60ADAYaEZ7WIw77iFiNWTb+l4QyeYz/AB9vjvI+
	 c/yESpc6WACDK1juAlgg9Bo2IR8LlL0DDogJpo0htY0W6HGaUCQeD9Jz24/4/hVKZ+
	 1ofZCbE9OELvU31DSTWaMS4Ly2deAvBofsl3Hsyk=
Date: Mon, 4 Dec 2023 21:59:49 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZW4vtQrmgUu29dP6@sunspire>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
 <ZWtWAPcJTNrD9wgv@sunspire>
 <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0roFwDt5J5hwuJL+"
Content-Disposition: inline
In-Reply-To: <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>


--0roFwDt5J5hwuJL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello,

On Mon, Dec 04, 2023 at 02:57:33PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 02, 2023 at 06:06:24PM +0200, Petre Rodan wrote:
> > On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > > > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > > >=20
> > > > 437:  ret =3D device_property_read_string(dev, "honeywell,pressure-=
triplet",
> > > > 					&triplet);
> > > > [..]
> > > > 455:	ret =3D match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > > > 						triplet);
> > > > 		if (ret < 0)
> > > > 			return dev_err_probe(dev, -EINVAL,
> > > > 				"honeywell,pressure-triplet is invalid\n");
> > > >=20
> > > > 		hsc->pmin =3D hsc_range_config[ret].pmin;
> > > > 		hsc->pmax =3D hsc_range_config[ret].pmax;
> > > >=20
> > > > triplet is got via device_property_read_string(), is there some oth=
er property
> > > > function I should be using?
> > >=20
> > > I think I mentioned that API, but for your convenience
> > > device_property_match_property_string().
> >=20
> > one of us is not sync-ed with 6.7.0-rc3 :)
>=20
> No, one of us is not synced with subsystem "for-next", which in this case
> is IIO "togreg" (IIRC) and it definitely has the above mentioned API.

v7 still contains the match_string().
that is the API available in -current (6.7.0-rcx), which is the version you
asked me to use a few weeks back.

whenever your new API call will be merged (6.8+ according to your email exc=
hange
with Jonathan) into -current I will provide a patch.

best regards,
peter

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20
>=20

--=20
petre rodan

--0roFwDt5J5hwuJL+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmVuL7UACgkQzyaZmYRO
fzB4xxAAg4++c2EfVeyasAxqVyaxt0/cEt/RDdKBiDUwn4NyAhTdDWslAzGbTssB
K1Kcp9IwHVjLJ59Rgni3z2jlTbMQmpxAfYdMYfCgK6C0LfcRVIqdW+E1DzrZMkJA
dQ2folIi3VBciFDNm6uezx1mX5qtpUYL5jgkOdxwP62K4VrFUHPz1UmCxEbZFIZj
9ZHnkZQnp+teHbKl/CI3LFpOerzN3IOOtqqeWoy1i+c/wERq2JsIDgVZUjcmHPaW
rShXD1Zfc3tEApzb0oqiboxVOHM5iQTZUwngR7trZrPoJFd6gns4FPv1xRTx//fL
unkhZM7nqk83OUxuWnGx0JMya/gBNUSe/JxTQCiqALLwjYt//ApsXkiZetkaGL8J
m27ELfYtC0eLjRHYS1tNRs07EO0JRMZxuhKoc4YUMfAnp4EkzFYF7h3foxhnTZrH
Wk3pT3wmAhr6YIeHSFetJfcXacFnqxvKTHPFzd3XgJFdMJMuO/UJdknYl1vSCqSM
ZoVPKugLgiWvCdLxr8etH3vIqdsoMvYlpmGRI6xNSVYftg98UBsY2KBmGwApl1xt
d260zwVVxB49DgsjSRL4zXsysciw+QdJI1MF5djEMblR34f/owfjeGybGhGn3MR6
w09EzwEJkLiTanx8PxLKTCmWOblXtfFcPrfSy0YfVH6iJQHwsb8=
=aQ99
-----END PGP SIGNATURE-----

--0roFwDt5J5hwuJL+--

