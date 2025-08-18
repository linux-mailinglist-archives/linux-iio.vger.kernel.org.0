Return-Path: <linux-iio+bounces-22955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 636B2B2B200
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 22:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D03AD1891673
	for <lists+linux-iio@lfdr.de>; Mon, 18 Aug 2025 20:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B47D1EA7D2;
	Mon, 18 Aug 2025 20:00:35 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9266186348
	for <linux-iio@vger.kernel.org>; Mon, 18 Aug 2025 20:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755547234; cv=none; b=mIgf+dQ5xb/4Q4LF4AruDkjYXSBzEzXBpjObQ7sFg7xltplczvBBR8oykRgaQoMyr+Dv4FaQHLT5iOBL2A1F8Wr5DPLob1SCFpAoRHc4HJMqlxaaYxH0UZhxrySQ0S4J6tY+3GT0wuBQrXH88TMKqjPM9XNoBPWy1oVbGpQLRb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755547234; c=relaxed/simple;
	bh=Y1fhPF4EO1aqpABek6ibxSTTIAeQUqnqZr+jBm8oxdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0Ip+IAIqGMI26pg9zzVII4FEEV3BU6X4re41sFVbN2v8Tt617twiY4bVLR7Ca6s5YmOxilenckcu1plMxHQzJ1mmjdRbj/68wkEJ8VXEbz8FmXv0EmMk6Hb302uMZ1M9IFGc7mMeJhsUL9E3s7boiqI3XW8K/F0FH/LVn7udKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 18 Aug 2025 16:00:20 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081815-encouraging-swift-df1d16@boujee-and-buff>
Mail-Followup-To: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250818035953.35216-1-bcollins@kernel.org>
 <20250818035953.35216-6-bcollins@kernel.org>
 <20250818191539.69e1882a@jic23-huawei>
 <2025081814-grumpy-prawn-ef1a0e@boujee-and-buff>
 <20250818201035.7a107dec@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fxbv3hrdirmhyra"
Content-Disposition: inline
In-Reply-To: <20250818201035.7a107dec@jic23-huawei>
X-Migadu-Flow: FLOW_OUT


--5fxbv3hrdirmhyra
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 5/5] iio: mcp9600: Add support for IIR filter
MIME-Version: 1.0

On Mon, Aug 18, 2025 at 08:10:35PM -0500, Jonathan Cameron wrote:
>=20
> > > >  	case IIO_CHAN_INFO_SCALE:
> > > >  		*val =3D 62;
> > > >  		*val2 =3D 500000;
> > > >  		return IIO_VAL_INT_PLUS_MICRO;
> > > > + =20
> > > If you want the extra space put it in previous patch.
> > >  =20
> > > >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> > > >  		*val =3D mcp9600_tc_types[data->thermocouple_type];
> > > >  		return IIO_VAL_CHAR;
> > > > +
> > > > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > > > +		if (data->filter_level =3D=3D 0) =20
> > >=20
> > > Return the current requested value. An error is just going to confuse
> > > someone who tried to write this before enabling the filter and then
> > > checked to see if the write was successful. =20
> >=20
> > I could not get a concensus on this. On the one hand, if a user sets a
> > value here, would they not assume that the filter was enabled? What
> > about cases where a filter_type can be more than one valid type with
> > different available coefficients for each? What should it show then?
>=20
> So I was thinking of this like other things with 'enables' such as events.
> For those you always set the value first.  They don't really have a type
> field though (well they do but the ABI allows multiple at once unlike fil=
ters
> so we end up with a quite different looking ABI).
>=20
> Agreed it gets challenging with multiple filter types. If it weren't for
> advertising the range I'd suggest just stashing whatever was written and
> then mapping it to nearest possible when the filter type is set.
> That's what the ad7124 does for changing between filters anyway
> though oddly it doesn't seem to have a control for filter type.
>=20
> This is a good argument against the whole 'none' value for filter type
> - that's not much used so we could deprecate it for new drivers.
>=20
> I'm not particularly keen on filter_enable but seems we are coming back
> around to that option to avoid this corner case.  Alternative being what
> you have here which isn't great for ease of use.

I'm somewhat wondering if the filter frequency and frequency_available
attributes should not even show in sysfs unless the filter_type was
something other than "none".

> So for next version let's go for that. Make sure to include Documentation
> in a separate patch though so it's easy to see an poke holes in.

Just to make sure I understand, you'd like to see a filter_enable
attribute and filter_type would not contain "none", then frequency and
frequency_available would always show something for whatever was in
filter_type?

> ABI design is a pain sometimes.

The epitome of being able to paint yourself into a corner.

--=20
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

--5fxbv3hrdirmhyra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEPsl1mBZylhoRORc6XVpXxyQrIs8FAmijhlQACgkQXVpXxyQr
Is//dw//Wj23qhhjbGDXw9ShxxpZDXjwpjXMeF2kdzusIndozPx/C2KahxQtPdZf
3dfyBqNFgSogJhVjoEysS49UApngDucxUawbNDD4YfOvDEnF6bZJ7z3givvAINGF
eDO/RZehCHiCtoIe7aA38SMxDZcc54V85f2vA+HbmhgPNSp0tgKuFbFdgDohChxc
1hJBsQuYTbD7PBPODLdR8gYLsoDENKjY3TYIB1ozKxIGtQo+uv1v0x9N3hzgmP0O
c/2DZpNkBTKcEKYAgakmTOaGmvlhWkBlHMIntVlLjTyOYGSOOEwtDGmHNbVq2jj2
yKy5+h7QzMQJthbjcMgxAH/Et/Y0uv3AZeGXnPyQaGcqqEiN2yJ7zq126nZFlieO
SLg+VBPFLyMHC4q2KIwJYG2qF9IIsXrbh6YBSHvtQav++uj4wBxPmngi3ghW/uAT
Wr3AkXya25EeapNlWBQdD33GkMFIpnx4l0CJoCPnx65+GppezoOC+0WQ6e9iqaXH
290hwLxcDIh4JMVH2BrIoClgqM2RptB+h7jq6y1kYzp3Fk6U/KPAbK2JBIgj+FIw
voh5V8fkiaA6JGlX0ccST6DdwzyYB4YTGQ/Oh50BBXZfe2vQE8OLHnZSVqeEcduk
STsSjlmTR7AV1pspyKCmOZ6QCnA/0WJWGM4sdI//dgtS1/+kkHc=
=oSUx
-----END PGP SIGNATURE-----

--5fxbv3hrdirmhyra--

