Return-Path: <linux-iio+bounces-27834-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 707ECD24D1B
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:51:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF33E3014DF2
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939FB3A0E88;
	Thu, 15 Jan 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQZQQ/xh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723D39B483;
	Thu, 15 Jan 2026 13:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485106; cv=none; b=D2AyY9E11YxBjrnm8kixxw4vzVcRKl7mw5wzLvWMOWeVNpTpR7FtGEhzMZ+QXNBObpgBUCBQ9oNQ2iYeEpIdy52+q+Jy1Er6f/5e0zpd5H0t3QQp0Q7Gj5KRObBm2FxPMCOqfBDOEkBuZkyusQ4Prpl/2u3Kl2pxUz5eWvKiYwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485106; c=relaxed/simple;
	bh=oB+NPCWOoAjDEgIqQfIcmLDbbTn0yy86FXBhckWJ5VY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxE60nawwNMuWSsnJpZStBB6g/v//XuId2FH1PHR3q6fmxdCBClbOpqvlcWdWLxoqLeeJ4xrPqxtfWKr0KkwebFdxTqYRWABRhcBlpvpwslC9OtUFOOE41zUzHuUxvkS1etv6jtZj78gmqik6v2OfnlLbqNNkpVf1cyOMFcx974=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQZQQ/xh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE29C116D0;
	Thu, 15 Jan 2026 13:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768485105;
	bh=oB+NPCWOoAjDEgIqQfIcmLDbbTn0yy86FXBhckWJ5VY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aQZQQ/xhQvFeAyXhSdCd+F1RU1YUV3rNd1BwfeiB05RzQwxPz0AtETYXo/gxc1GSp
	 Z5nXTTXqRJMbL+PMII3H67D2i0slBJj0eu3/mNFnsT8nSdbaPJHtcoRw829DdyIOqV
	 uxGWUrZP7Rkzurm0fiM2YWrgaxJz1188jfijS+bwuREBmiSPz1jy3o1nOA4ZjB43jx
	 +uqEK9YT9KzytMXDJe0ARJ4Z91PUP0MZUU1SeaPJcTSpVoTLsGvwdm09+tFln41oC3
	 O9SvjyfwsOrlRZCSNjfhDGOJDYmOkt1PvwRTwd7liNTNosQLoeAX/gtAPRNhC7k+yb
	 dEEvoX0XYWj4A==
Date: Thu, 15 Jan 2026 14:51:43 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aWjw7_poJUIh9HgI@lore-desk>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-4-flavra@baylibre.com>
 <aWjsWzo3PXHKsdJX@lore-desk>
 <aWjwWF2XmXJb-iJI@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DB4VvpfM/B3fFuv6"
Content-Disposition: inline
In-Reply-To: <aWjwWF2XmXJb-iJI@smile.fi.intel.com>


--DB4VvpfM/B3fFuv6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15, Andy Shevchenko wrote:
> On Thu, Jan 15, 2026 at 02:32:11PM +0100, Lorenzo Bianconi wrote:
> > > Some IMU chips in the LSM6DSX family have sensor fusion features that
> > > combine data from the accelerometer and gyroscope. One of these featu=
res
> > > generates rotation vector data and makes it available in the hardware
> > > FIFO as a quaternion (more specifically, the X, Y and Z components of=
 the
> > > quaternion vector, expressed as 16-bit half-precision floating-point
> > > numbers).
> > >=20
> > > Add support for a new sensor instance that allows receiving sensor fu=
sion
> > > data, by defining a new struct st_lsm6dsx_sf_settings (which contains
> > > chip-specific details for the sensor fusion functionality), and addin=
g this
> > > struct as a new field in struct st_lsm6dsx_settings. In st_lsm6dsx_co=
re.c,
> > > populate this new struct for the LSM6DSV and LSM6DSV16X chips, and ad=
d the
> > > logic to initialize an additional IIO device if this struct is popula=
ted
> > > for the hardware type being probed.
> > > Note: a new IIO device is being defined (as opposed to adding channel=
s to
> > > an existing device) because the rate at which sensor fusion data is
> > > generated may not match the data rate from any of the existing device=
s.
> > >=20
> > > Tested on LSMDSV16X.
>=20
> ...
>=20
> > > +	settings =3D &sensor->hw->settings->sf_settings;
> > > +	switch (mask) {
> > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > +		u32 odr_mHz;
> > > +		u8 odr_val;
> > > +
> > > +		odr_mHz =3D val * MILLI + val2 * MILLI / MICRO;
> > > +		err =3D st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> > > +		if (err)
> > > +			return err;
> > > +
> > > +		sensor->hwfifo_odr_mHz =3D odr_mHz;
> > > +		return 0;
> >=20
> > break;
> >=20
> > > +	}
> > > +	default:
> > > +		return -EINVAL;
> >=20
> > break;
> >=20
> > > +	}
> >=20
> > return err;
>=20
> Why?

I guess it is more clear, but just a Nit, I can live with the current imple=
mentation.

Regards,
Lorenzo

>=20
> --=20
> With Best Regards,
> Andy Shevchenko
>=20
>=20

--DB4VvpfM/B3fFuv6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaWjw7wAKCRA6cBh0uS2t
rLwmAQCCwxOcOOP/wlJ4w7vjcGD39gPziGivo0kb9KNx0z2PPAD8D1sTsIBPbAhg
SQEnlLx/f94sot9b4Dj+M9BsYdr13ww=
=AkNe
-----END PGP SIGNATURE-----

--DB4VvpfM/B3fFuv6--

