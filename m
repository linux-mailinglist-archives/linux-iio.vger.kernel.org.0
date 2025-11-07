Return-Path: <linux-iio+bounces-25999-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC155C3DFA8
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 01:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 992884E6DBE
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 00:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6479D246BD8;
	Fri,  7 Nov 2025 00:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="vz1xJ4ZN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE41F19A;
	Fri,  7 Nov 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475452; cv=none; b=CuUoces3pkumgL6vx9T712wNo+0TvplQqzb3gXom0pAYRe8ZHtFzzx2KvE3jwodsGOcDgh5xkz39o5henZ0NpSmIvIlIjrRglNoFGyLR+urOiBu5D6RTAlYvVKfNMhBB2e+nlUBYiUadDw2LL6G9oIRPVUloXRDhFJDeqIWqgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475452; c=relaxed/simple;
	bh=rbYZFDhnLDpEpqh6sqUJeLRBPVCKU6SN6dWVJ2axnoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdfzDn1Kpnkp1oC4pk0K8caxZ5K+xr0/fcjOIY1dzDLiC3eh8kwMV6eVcLQ6VE3TAzlvcLEIYnwPJ7XvJWscT3vG9fhHxrWga0fDtnq7WUOEcxYDguKCn7Whu8DFD0kerciprbeDmTjsCVEUVqtMuxnUw05/ddpB8YVuy/RHBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=vz1xJ4ZN; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3e0c:5b00:f1e0:3f4b:286c:9ddb])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id DC9B6160209;
	Fri, 07 Nov 2025 02:30:39 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1762475440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gu0/BUJoXynDAUB8R6H/4sFrLhmyaLY5XvHLuteKYUA=;
	b=vz1xJ4ZNN0Oc8OJ8PUha5ATdtvhD8CjOaIDgZoLRb9iPzi5r2nPhCDp5sPlsaTC1yD80mG
	K3T9nunvb6l5iQI+A6CYLO8xCZ3cZSazrrrsGXxZCTDTZZo0oac8y3NfZv8PlZD2drU+C8
	8pFwVnLyHKIJwqLUVshHMN3TX43jQknjBMTi5vZHKmbJWMtcK0Wa92DYsObTiHKwpaw9nt
	9iSsuLdCHPRQPTTXxANeAEHdHU2fNMcGhW1zGabQpA36B5S6ezxkObhV5cuqlzsqvz09gn
	FFe+ILx8L3j0O3lg2TG6bybX8UB7zePRa3l82mWColM4Np/EkffJ0gHYrSUP1g==
Date: Fri, 7 Nov 2025 02:30:33 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jagath Jog J <jagathjog1996@gmail.com>
Subject: Re: [PATCH 3/6] iio: accel: bma220: add tap detection
Message-ID: <aQ09qTYr0gqlb0If@lipo.home.arpa>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
 <20251014-bma220_events-v1-3-153424d7ea08@subdimension.ro>
 <20251018181632.76851d4e@jic23-huawei>
 <aQW9OnJSrOzn_Sws@lipo.home.arpa>
 <20251102122053.49ee2632@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VSn+NfuX/JxFTYS/"
Content-Disposition: inline
In-Reply-To: <20251102122053.49ee2632@jic23-huawei>


--VSn+NfuX/JxFTYS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2025 at 12:20:53PM +0000, Jonathan Cameron wrote:
> On Sat, 1 Nov 2025 09:56:42 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Hello Jonathan,
> >=20
> > thank you for the review.
> >=20
> > On Sat, Oct 18, 2025 at 06:16:32PM +0100, Jonathan Cameron wrote:
> > > > +			ret =3D regmap_read(data->regmap, BMA220_REG_CONF3, &reg_val);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +			*val =3D FIELD_GET(BMA220_TT_DUR_MSK, reg_val); =20
> > >=20
> > > This needs to be in second if you are using duration. Is the register=
 really in seconds? =20
> >=20
> > this IC has a very small number of bits that configure
> > duration/hysteresis/threshold levels. it's between 2 and 6 for each
> > of them. in the case of high and low G events the duration is not
> > even directly defined as a time interval, but as a count of samples
> > that are over a threshold value.
>=20
> The ABI is in seconds, so you have to deal with scaling wrt to the sampli=
ng
> frequency at the time.  I know it can be a pain to do, but consistent use=
rspace
> is the aim and so we need to match the ABI.

on this bma220 chip, when someone modifies the cut off frequency of the fil=
ter then the ic automatically adjusts the sampling rate. and this sample ra=
te is not exposed on any of the registers.
since duration parameters are defined as a count of samples and the sample =
rate looks to be unknown I don't see how I could adapt to an API that is ba=
sed on a unit of seconds.

> > I was hoping that simply passing along a unitless value between 0 and
> > parameter_max would be enough to customize all the event parameters.
> > this does mean that the driver makes the assumption that the user is
> > familiar with the device datasheet and knows the number of bits every
> > parameter has been allocated. should the driver provide a conversion
> > table for tt_duration just like for _scale_table and
> > _lpf_3dB_freq_Hz_table?
>=20
> Exactly.

I was thinking today of a more analog-feeling API, one in which a variable =
that can take values linearly between min and max can be set to a percentag=
e of it's scale. think of stereo systems - most of us don't want to set a p=
recise amount of decibels of attenuation when operating the volume knob, we=
 just want to set it lower or higher until a condition matches. in this API=
 the primary unit of measurement would not be dBs but notches or ticks - ca=
lculated based on min, max and the native resolution of the control (how ma=
ny bits are allocated for it in the ic's memory map). this has also the ben=
efit of translating nicely when the control is rendered as a widget in a GU=
I. think about a 0 to 11 volume knob.
is there anything like this already implemented? is there any merit to this=
 idea?

 I will shelve the event part of this driver for another time, just got som=
e Honeywell pressure sensors that need a new driver.

best regards,
peter

--VSn+NfuX/JxFTYS/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmkNPaIACgkQdCsnp2M6
SWM73w//WsL6yDvpxuWQzPxfjXZHsBJoah8ojgxzS2EvrD7ijEyBCpI/tgrljytM
EksqfXO29+YQYLM+z+xru5W/lMC7w8xM1J0UCgJZMJ38hi6zrbGlXGxqGW5cAgDy
BfR6tWjKixPaDJV6D5t9M+gTmJMVDJxnQ1FuKoAggpBKg+f/3/rZdTkdF8GIe7Wl
/b8v9bvZ4RtCsETl2ithaOLC3CUdJj38Z3Pc4YNDpViMxCpZ/Cjm4IkCTnCRviBu
6h0bx7hYEGwOA4SirzMtJj+xTfkHWeKzfw/KxYc1TrGayKgjCaq3yiYurosuwtw6
Wr0dO/U2iQPHPEyYz486pVx84O34AnfRczQZWS6Gw8e4kYUjzZYv6iFRYncGjg2S
2CBTjSZqurNhrIbw6S8U7A4K44OZr3AR4cHgI+AQvou5Oss8NX+INrlZSLF8dsqV
oAiVZUTUulWXDriZM6iZXOBwU8C/M4Qp1IkVlsnhHva/4bqxusa//TAQCTCF7N3N
cjPgW8T2VoyC1bwGZRkV1JWLWbyoHXpCbNGq/Bu9+KXgAuiWGb6cKd+4rWxZmjA2
onP5MqTS1gkAsDtXjoKkim1SgJnsW5kEMFcJpdHGXBLxZvvRqyVRGMz+Bwd/qE6j
DXXss8o/WznLIFkRI+96iSzW6ZRYXz3kL9/+YGfqiEFw5kKuQVI=
=QZSc
-----END PGP SIGNATURE-----

--VSn+NfuX/JxFTYS/--

