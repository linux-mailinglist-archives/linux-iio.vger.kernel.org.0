Return-Path: <linux-iio+bounces-23871-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A87B482E0
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 05:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042B617DE78
	for <lists+linux-iio@lfdr.de>; Mon,  8 Sep 2025 03:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9120ADF8;
	Mon,  8 Sep 2025 03:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="PYYpWt7t"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06201FF1B5;
	Mon,  8 Sep 2025 03:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757302033; cv=none; b=oEBqBRgnmZARL6hY7NPtgmx1Sp8OCS5kEGWCgqn1BQSUFQZqBng+l9rqIa9aVkZ9dkSpN6hx8lfE0t7hxpbi4SFhDoY4SG4NV0UffERgA4XKg1yLNH+iYZS01zfUv6tL/ms/AK4WC16BRB8fTDqklKJdJQqMAcgKKUqLMZhYZ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757302033; c=relaxed/simple;
	bh=hYKAnkkRC03lgxUIsEc7VRnyXmGbSgcYkE5SXUc6oPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WxN3Z/kM7zSpl0+nqiEIyplSfORQ6vZquEAOVUs5Cbha+CMlcURrqYoB64SNjWD5Nep8m8e1xL4ZoXLjPYae1P0daN9hADMvYhvp60hkxFvODpxarkood6diSRGbjGQKBXt+9TY1PX/i0JWYuvYxiyt+ZCUb+GlbHcuu/8u+BP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=PYYpWt7t; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [IPv6:2a02:2f0e:3503:4a00:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 0FF54173BE2;
	Mon, 08 Sep 2025 06:27:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1757302028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BN3qREvBY72zOVP7T0gB8HXLT3gbh998Niiirc/UhnQ=;
	b=PYYpWt7tcv1PzGufErRgxpqKnPELOap92CrB2Tcg0x/rAR3R4DSf1JR5nc4hIryeKbU7OJ
	GidJ3lcW4CulYJxRMn2cZSwAwp3Z2LY18ioa2UBriAOQ9Wva3sX1YyU/DSlZeeTwynvElY
	cGqnNWC50xh+HcDpbo4LrNlhHQ8h0h3o0yebrikYjAVDnRte1mCvw4kjTD044MLN880Gxl
	6ArfQ3HpJomZmwwT1jozd6PnubQVhoevpBh6GRWfJonoyjMq+UmnHGBQ5X/O5s/SEqqxG1
	65lacwtArOrKMjwkg+Dfynan/e9eqreOp9EHdSn3xeHdtIVgn8s/cjkD1rP/EA==
Date: Mon, 8 Sep 2025 06:27:05 +0300
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 03/10] iio: accel: BMA220 migrate to regmap API
Message-ID: <aL5NCVh9WylPhZ1O@sunspire>
References: <20250901194742.11599-1-petre.rodan@subdimension.ro>
 <20250901194742.11599-4-petre.rodan@subdimension.ro>
 <20250907134506.580de654@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WKdEbefMa59kZAe4"
Content-Disposition: inline
In-Reply-To: <20250907134506.580de654@jic23-huawei>


--WKdEbefMa59kZAe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 07, 2025 at 01:45:06PM +0100, Jonathan Cameron wrote:
> > +static int bma220_reset(struct bma220_data *data, bool up)
> >  {
> > +	int i, ret;
> > +	unsigned int val;
> > +	guard(mutex)(&data->lock);
> >=20
> > +	/**
> > +	 * The chip can be reset by a simple register read.
> > +	 * We need up to 2 register reads of the softreset register
>=20
> May need?  Given you return early if the first one succeeds. If you actua=
lly
> need two drop the loop and only check values on second read.
>=20
> > +	 * to make sure that the device is in the desired state.
> > +	 */
> > +	for (i =3D 0; i < 2; i++) {
> > +		ret =3D regmap_read(data->regmap, BMA220_REG_SOFTRESET, &val);
> > +		if (ret < 0)
> > +			return ret;

I'm not sure how eloquently I can explain this. the sensor can be in

sleep state / non-sleep state
reset state / non-reset state
(these overlap)

the sensor toggles between these states when the master reads the suspend a=
nd
the soft_reset registers respectively.
based on the value read one can tell what was the previous state the sensor=
 was in.

bma220_init() simply places the sensor in the non-sleep AND non-reset modes=
 (and
resets all configuration registers so that we start from a known initial co=
ndition)

'may need' is used because the sensor might have been left in an unexpected=
 mode
in the previous session.
we need at most two reads of a register to make sure bma220 ends up in the =
state we need.

best regards,
peter

--WKdEbefMa59kZAe4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmi+TQgACgkQzyaZmYRO
fzCg3A//Tv0He6BWNBMOvNc/DqeM6+IX2jeZZzJuKzTtMLt8HPPmcpQtrqGDdnTG
xLYQY51oEzBr0K8KCHj/z7ZmLxagEwqe2xQkx6XJg3E5ntXnri7CZ2CrmCtV7tKB
Ire2QR2qEWFQY7TvG4iDVQE8lRl4Z/s8Cx9JJC02es5bGE080uxHtbvx89eopKbK
g31lYzNiJBETS9F4f7SPf0FQB0dmlHwUc4Ra4AW3Z/mjdI6X8BTUUaXrAJ9VdyEW
UkQGMzV/la80CeRC/CADkyt5tvHmbz2u7eDyId8TXdUKcVI3JTS2QnuKDzs2rU2U
ZN0O6gfzVrDA6u+DGUe/ipWLLr+OpMRsKE6PgMu+5VzPwvZSxAdfBhuw1X0zvg7w
R5iHj4aSPcj9IoPPk8Erl/S5Y/3vQUzvDBUIMkT2aBC+mPeL2HHJHBga7hSvZ+Om
yFJS/N3acKtwWWq2I52DXmYqTMQIT5wqweqns84AFt0kcxxsTFIxKkt0UP5eTL4d
AoHa660glDzeqEsaG6dEeNfIcxGn9tKElaEaxkdca8mA2ln6T4JyzlpDfLCYr3AP
5Hyh7uEuQ0wheqmq3bNb6pJmq8pLH+zhv/70HCqEIAaxESptJnuCbCId0KT2NAFM
E8bG35JTTGYs+vaEOHHqy8ZdxhpTd5FC7jowERh0UDzmYTGfYpE=
=7TgT
-----END PGP SIGNATURE-----

--WKdEbefMa59kZAe4--

