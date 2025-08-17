Return-Path: <linux-iio+bounces-22857-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B1CB29138
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 04:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF41882521
	for <lists+linux-iio@lfdr.de>; Sun, 17 Aug 2025 02:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3819FA8D;
	Sun, 17 Aug 2025 02:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XY5Wfdrr"
X-Original-To: linux-iio@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF60191F89
	for <linux-iio@vger.kernel.org>; Sun, 17 Aug 2025 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755399273; cv=none; b=s+N73ybPt8fXcmvBucJKcZdLPtQ6aEHvMGiL9CpXxNqcXi8avzQT3Qpmb83tLwdnAABhsc+1kKCIc3Zse/0rpMDh4n7aOQsGgaOBX4ob9Yy+bZgJ7lwaD+ib13Ey71mUmaB4sttMSvMFkPQzq2/b8AUAO/5vyzEsbzr5C/1/yXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755399273; c=relaxed/simple;
	bh=1eMkf5LCFwtUYzwXMABjzbSdFSshBHvrGUykSmtf6+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhktiqGPHaWEJPriu9DyoUJk+A8Oi+/JxYh6IP2RFlm5/L/tZY1mmOD2Z+xgm5nT/IM80fIi7jhubLH8w+0TeAcZlmmcvrTDKqNyMw0CPDaBRqthg/UkwMcl8V2PRb0Zg5KKZPazKnA2wIBqRSsfVLs+qqL5EFCzLM42Locdr+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XY5Wfdrr; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 16 Aug 2025 22:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755399259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bBjFdPleu+KBxiqnCwIGjPrJIE2i+LhqwX8cHNGFxH8=;
	b=XY5Wfdrrbht625cxTPE5P8/2Tta7XOpOijdt3URKUj6woBKtp5bLqwdzb8FDjjP9RcpbYl
	FPVXeA09hUUMgOt7ip+xtritug1dMNQMOch+LfyoLSy+1zYYf98GsCnNcr12/YmntJO+U2
	nsJNrI8Rqfvvo9BJvvWN/ScIAQ2yxzk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <ben.collins@linux.dev>
To: David Lechner <dlechner@baylibre.com>
Cc: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
Message-ID: <2025081622-industrious-dragonfly-ed3cba@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250815164627.22002-1-bcollins@watter.com>
 <20250815164627.22002-5-bcollins@watter.com>
 <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="46wvsol27p4dv5pj"
Content-Disposition: inline
In-Reply-To: <7cd6f642-b26a-45aa-a2f2-ccb7fbc28b20@baylibre.com>
X-Migadu-Flow: FLOW_OUT


--46wvsol27p4dv5pj
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/5] iio: mcp9600: Add support for thermocouple-type
MIME-Version: 1.0

On Sat, Aug 16, 2025 at 01:24:24PM -0500, David Lechner wrote:
> On 8/15/25 11:46 AM, Ben Collins wrote:
> > dt-bindings documentation for this driver claims to support
> > thermocouple-type, but the driver does not actually make use of
> > the property.
> >=20
> > Implement usage of the property to configure the chip for the
> > selected thermocouple-type.
> >=20
> > Signed-off-by: Ben Collins <bcollins@watter.com>
> > ---
>=20
> ...
>=20
> > @@ -453,6 +504,24 @@ static int mcp9600_probe(struct i2c_client *client)
> >  	data =3D iio_priv(indio_dev);
> >  	data->client =3D client;
> > =20
> > +	/* Accept type from dt with default of Type-K. */
>=20
> We still also need a dt-bindings patch to specify the default there as we=
ll.

The existing bindings file for this already states type-k is the
default. Is there something else it needs?

> > +	data->thermocouple_type =3D THERMOCOUPLE_TYPE_K;
> > +	ret =3D device_property_read_u32(&client->dev, "thermocouple-type",
> > +				       &data->thermocouple_type);
> > +	if (ret < 0 && ret !=3D -EINVAL)
> > +		return dev_err_probe(&client->dev, ret,
> > +				     "Error reading thermocouple-type property\n");
> > +
> > +	if (data->thermocouple_type >=3D ARRAY_SIZE(mcp9600_type_map))
> > +		return dev_err_probe(&client->dev, -EINVAL,
> > +				     "Invalid thermocouple-type property %u.\n",
> > +				     data->thermocouple_type);
> > +
> > +	/* Set initial config. */
> > +	ret =3D mcp9600_config(data);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ch_sel =3D mcp9600_probe_alerts(indio_dev);
> >  	if (ch_sel < 0)
> >  		return ch_sel;
>=20
>=20

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--46wvsol27p4dv5pj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmihRFYACgkQXVpXxyQr
Is+Jgg//fCKYOKY9RxUVrSkR5q+eTSj1b0JFkVtRrzpnfKLnNMSrGeaaE3rqxVGc
jcNxW/xvWCuold0V3Km6ee12W330vEoT5rgHBapLkYaX2JiS2DwvgMMr+nJGwsSE
hk0kJWi2SKK1Xwm9Upv5On+Wh3VxkiDcgiiGH+S+GyjhJVN1P9GN70RFZzQUO8pO
PaCrGyfiOHVBj7A+zXO24N31qKR8hbgcCeS0qbuhMaNRzg154S/0b2nHruGm8ptz
/hG1CGaUk+gqm3a5Qr7cKwmvagTH0/9Zsxz2Ds6dXXM4WwstO2CNHcNlDk5kaNMn
YLwTHYz1c6VM0LI12PoHnJZMKZMxuPdVFdR6GGR5rV0Vv5jUdZwwB9SjeJVniLWT
mux0AicR1id/I2to9IilM71cXQNm4xUSQHHOufXds4Oony3gREva9W2T2UfgMNgq
V8fwBHAThZXQQCq9fLhmR4Bq7CTovFl3762sxn/gU4xqbfoSkBrOy3sRET5XllgQ
Et7dqaL86JsKnB/Cf8m/0ByXjC0T12BqLHj3hq199VJqInxjp1i56y6gXkHRi7AW
kZem7GYG4jiW6g+v0GW12LMvYO71o7pvAsylLJ3Tojol+6ATE/NbxZjVGpSXASZq
szfpOdTvbPZrYSYJfswoLjYKOtHesYSosEzaKLW9ZIQ97HwR0yM=
=8Jyl
-----END PGP SIGNATURE-----

--46wvsol27p4dv5pj--

