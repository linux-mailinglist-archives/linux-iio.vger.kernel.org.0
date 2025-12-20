Return-Path: <linux-iio+bounces-27257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0A5CD2A5D
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 09:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DE90301513F
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 08:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045182F691F;
	Sat, 20 Dec 2025 08:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="wcuP7Neq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032A81D90DD;
	Sat, 20 Dec 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766219126; cv=none; b=L6NqV9k9TjcdCE+QOwkKMSVbyPg50VWSwKRgsz29P8UyQka+iXcF0AHUBqNgpQOBXgUZx5TGwsHymeMrGIOxRs3u+ykX7wr/i2XxQHJ99/uvfRlAF7RPCS3kwLBaWcFpAzvncd918s1TiqONp1Au5iY5FHG6V72Log8IZhtVJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766219126; c=relaxed/simple;
	bh=J/g5p0yVuUJga1D56jQE8+El+A9EqWMBa68xloOLQok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oD+mzGwLuYLT85kjWz3XXYeoewnMdPoC0hE72B7xgvpT24jGnsURMby+aJwSMRiWpbjcG6DjnAJKpPe4VcGXc8t/U4F9ZAWU0FsYVMWtN6qx0iiorvpK//SPplbXk6rHXAKYSUwULYaHNNVVKEBWhxjtP8Ll19NFO/5F8+AFGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=wcuP7Neq; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6DAE2160209;
	Sat, 20 Dec 2025 10:25:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766219122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VVlWLT0OiLNanbSYkmxwheITGaHT1XI8QkzVmIM2hkg=;
	b=wcuP7NeqezvdSvX4p3Ji56o66dMo+yjaHYSl6GLhqeKb+QGIS7P3+/l/2LOf9tjPYdplXK
	wJRWUiZL9gGY0dZqANFQDXh3p1K7KGu9cSSksQJXzFD59QamU80S2RLg98PQB0jNs+UHUf
	FI46m4nYIJlBuVQYKlkwlRNoqYIK58pTfFEUWIpdCFO59ZApZGLjKMC2bpabbORNPviUCU
	SDgG57+Ft5DNA2bi3JwsoZ+R5RApWG/vTGvxpxOThUe8Sq+r/fG178xqPvHPBy19nI5ALc
	tmqnoD+GqXi9hVqakdkRBqjSRfkyAIzRnr6dGBry8dLwbfrKBwrRAL3e5kV60g==
Date: Sat, 20 Dec 2025 10:25:19 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
 <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+qKjAMj95J81NkLd"
Content-Disposition: inline
In-Reply-To: <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>


--+qKjAMj95J81NkLd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello,

On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:
> On 12/18, Petre Rodan wrote:
> > Zero out input buffer before reading the new conversion.
> > Perform this operation in core instead of in the bus specific code.
> >=20
> > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > ---
> >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/pressure/=
mprls0025pa.c
> > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > --- a/drivers/iio/pressure/mprls0025pa.c
> > +++ b/drivers/iio/pressure/mprls0025pa.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/mod_devicetable.h>
> >  #include <linux/module.h>
> >  #include <linux/property.h>
> > +#include <linux/string.h>
> >  #include <linux/units.h>
> > =20
> >  #include <linux/gpio/consumer.h>
> > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *data,=
 s32 *press)
> >  		}
> >  	}
> > =20
> > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));
> This is unusual and I don't think it's needed for the SPI path. Doesn't t=
he I2C
> subsystem overwrite the rx buffer with what it reads from the device?

I thought it's best practice to ensure that old conversions are not acciden=
tally re-used in case the read operation fell thru the cracks.
that's exactly why in this particular case the BUSY flag is implemented on =
the hardware side.

please tell me how a few byte memset() would be detrimental.

best regards,
peter

> >  	ret =3D data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
> >  	if (ret < 0)
> >  		return ret;
> > diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/press=
ure/mprls0025pa_i2c.c
> > index a0bbc6af9283..0fe8cfe0d7e7 100644
> > --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> > +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> > @@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, const =
u8 unused, const u8 cnt)
> >  	if (cnt > MPR_MEASUREMENT_RD_SIZE)
> >  		return -EOVERFLOW;
> > =20
> > -	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
> >  	ret =3D i2c_master_recv(client, data->rx_buf, cnt);
> >  	if (ret < 0)
> >  		return ret;

--=20
petre rodan

--+qKjAMj95J81NkLd
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlGXWwACgkQdCsnp2M6
SWPcPRAAn1GMk3W5pJEU/UZjuolMr9MMXGSzkeoXz6jqO+WqB4lnGcmdfZSDi7Cs
j1Bp+nWKRVVQTZjn/DoCJXedbuhTMc0EGNaEZseSUEUtF26gIdnV+tZsu8UWSYD/
SvphTfudwKguiP+Vwbym7hhaNA1TJ6R/XwavVHhPkqbnH8t2xuAg9KeVU7G9B1GA
78PkUSP8KpSA536CF+1CzBXe7ETW+ReysyZOYx9dpsRKInetojBrkubI61rFMP5V
uakVJl95Pafib9AftD4Id+RFJE/csJTFEAEp+H1ZRueJ+CJ9wjq3lnKjCywR9mzP
wz41MrMK8CutTCAA0taV0AXNGi+OFV7FLp7Foi1UhEuC+Wq9W2TBnXoMQpLx10lm
BDZw9bmWcaYVPOdWvlBPOSWJTTuaqWyfeJcq9QT66UJpXcG+qRfG+3MMnR97kxbp
vxqWhpLezn1SKjEVZFIL6GHilz/Dvxov/3D7HQuyrqd5bh/xbSF9eMKmGgcSAVEg
dqPz+vB5JC2t97t3c2jsyDNo3lQK/3QSfRI5vaZ2yACqGa/0e6wEsWTR05zhb2ln
vUkKayXsa0xk3r+xgv9X4rBDxKFxt7L1p52ZaNPp6TLhS+WSmo9RTw/uja+rAB4l
6PD5YkIhe4iH9H4QFTVF89pN8v1Fpdpi0X4qWKLB9qKaSLROk9M=
=yjuu
-----END PGP SIGNATURE-----

--+qKjAMj95J81NkLd--

