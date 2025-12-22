Return-Path: <linux-iio+bounces-27306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C202FCD4BF2
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 06:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 490493001C07
	for <lists+linux-iio@lfdr.de>; Mon, 22 Dec 2025 05:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B7A322DAF;
	Mon, 22 Dec 2025 05:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="iPb1E0rZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197CB35975;
	Mon, 22 Dec 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766383091; cv=none; b=qDtJ+OnyaPFS6+8MvdGf7aVTenlhkeKVUgheShWD/NWHMV1hHZ3Jouq2Rhd17TtmUEWEquwCZ6LkmUiplhr9Kqy3Umiil/n5xboiRan7opq1HhHq5m/NBxs4qPnl/S30dsMsTqY0Qi6zhsQHyLu/ABkSGIVTGB5OH+A1dWd4G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766383091; c=relaxed/simple;
	bh=MBzm+X9hho67q0oOzCAUxzPOLkyvU9LPiP/gxDe+WMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrioKOD/rgRYFy0bd9CNmkRw7OxLvHuRR9IB6xlR4TvVYvjKqO5qkENosR6n2F7cET3yY5gUxf8A7dBNqTLH6pKMWDMjZlZ4klPV51E/7CBvxM24OhvsHJPG1BifW9x5cnMk8AZsTxTHHYxgzI962n6CiHYD38/0NM9Od7YK8kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=iPb1E0rZ; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from lipo.home.arpa (unknown [IPv6:2a02:2f0e:3804:ac00:27be:5960:c272:6ea8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id F3EC7160209;
	Mon, 22 Dec 2025 07:57:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1766383080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lp5FqwQzsj9UWJAet5awSSts7ha6mkc5web3sNGKmdU=;
	b=iPb1E0rZ/tPya2d4MyvRzBn0MbVBkGSxmKj9uWKZ9AB7KRWIUCtfpSlcPC1QEFVZ0sQRLG
	1l82HXmN8PKInNevjBWzPdBhuZZB2BgIVtaEwV1PHKPa03Kvl1GraXww7Zc1q+avqkdwP/
	vLw6hylJdyWV83i7VokXlcs15HEvgqmY/VJnN3Qvj8Py7vuqN9IlzknIsCbZL0dkLPnjYJ
	TznmSMKrmDJ3j2BpWNNL7WGsWyHyaxSWHAkKXmHXIVq9TA+CliEwaMoE+GkNZTLVha6LEg
	WcAYsJw2Aq8PT7HP+tWW2Sn+d3vcFdRaNz+n2ei9YCsO7RMbjum8jHou6FIn7Q==
Date: Mon, 22 Dec 2025 07:57:56 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <aUjd5AJHohyW_kXM@lipo.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
 <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
 <aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
 <20251221182151.288a6da4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N9jafWnzupNT5HVQ"
Content-Disposition: inline
In-Reply-To: <20251221182151.288a6da4@jic23-huawei>


--N9jafWnzupNT5HVQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


hello Jonathan,

thank you for the review.

On Sun, Dec 21, 2025 at 06:21:51PM +0000, Jonathan Cameron wrote:
> On Sat, 20 Dec 2025 10:25:19 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Hello,
> >=20
> > On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote:
> > > On 12/18, Petre Rodan wrote: =20
> > > > Zero out input buffer before reading the new conversion.
> > > > Perform this operation in core instead of in the bus specific code.
> > > >=20
> > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > ---
> > > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio/press=
ure/mprls0025pa.c
> > > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > > @@ -16,6 +16,7 @@
> > > >  #include <linux/mod_devicetable.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/property.h>
> > > > +#include <linux/string.h>
> > > >  #include <linux/units.h>
> > > > =20
> > > >  #include <linux/gpio/consumer.h>
> > > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_data *d=
ata, s32 *press)
> > > >  		}
> > > >  	}
> > > > =20
> > > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf)); =20
> > > This is unusual and I don't think it's needed for the SPI path. Doesn=
't the I2C
> > > subsystem overwrite the rx buffer with what it reads from the device?=
 =20
> >=20
> > I thought it's best practice to ensure that old conversions are not acc=
identally re-used in case the read operation fell thru the cracks.
> > that's exactly why in this particular case the BUSY flag is implemented=
 on the hardware side.
> >=20
> > please tell me how a few byte memset() would be detrimental.
>=20
> We don't normally do this as old data isn't a potential leak of anything
> sensitive.

=66rom my point of view as someone writing drivers for chemistry lab instru=
ments, stale readings are to be avoided at all costs.
it's not about leaking sensitive data, it's about providing a warning sign =
if the read operation fails silently.

as an extreme (but fictional) example, a pilot looking at an altimeter woul=
d immediately recognize that something is wrong with it's pitot tube if it'=
s giving out an off-scale static reading. if instead the output is believab=
le (which would be the case when older readings are repeated due to an unca=
ught intermittent read error) then there would be some uncertainty and he w=
ould not know to definitely ignore the output of this particular instrument=
 and trust another one instead.

the same logic applies to any instrument in a lab setting.=20
a digital titration system that mixes multiple reagents needs to rely on fr=
esh conversions to know when to stop a process. some advanced sensors even =
provide an incrementing conversion counter, others simply signal that a mea=
surement is ongoing/not fresh via a BUSY flag and these are designed so tha=
t the driver can avoid a stale reading.

getting back to my driver, some pressure sensor series have a latch-up sens=
itivity and they misbehave during reads in various ways under certain condi=
tions. I understand that you say that silent fails are unlikely but I'd lik=
e to keep the memset, for peace of mind.

> However in most drivers this only spills out at all as
> a result of say a change in configured channels and is normally harmless
> as userspace knows to ignore stuff in the gaps anyway.  If there is
> another cases here (you mention the busy flag) then add a comment on why
> it makes sense. I don't in general want drivers to start doing this as
> it is in the fast path and sometimes the memset is non trivial (here it
> is probably irrelevant as the buffer is small).
>=20
> Thanks,
>=20
> Jonathan
>=20
> >=20
> > best regards,
> > peter
> >=20
> > > >  	ret =3D data->ops->read(data, MPR_CMD_NOP, MPR_PKT_NOP_LEN);
> > > >  	if (ret < 0)
> > > >  		return ret;
> > > > diff --git a/drivers/iio/pressure/mprls0025pa_i2c.c b/drivers/iio/p=
ressure/mprls0025pa_i2c.c
> > > > index a0bbc6af9283..0fe8cfe0d7e7 100644
> > > > --- a/drivers/iio/pressure/mprls0025pa_i2c.c
> > > > +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> > > > @@ -25,7 +25,6 @@ static int mpr_i2c_read(struct mpr_data *data, co=
nst u8 unused, const u8 cnt)
> > > >  	if (cnt > MPR_MEASUREMENT_RD_SIZE)
> > > >  		return -EOVERFLOW;
> > > > =20
> > > > -	memset(data->rx_buf, 0, MPR_MEASUREMENT_RD_SIZE);
> > > >  	ret =3D i2c_master_recv(client, data->rx_buf, cnt);
> > > >  	if (ret < 0)
> > > >  		return ret; =20
> >=20
>=20

--=20
petre rodan

--N9jafWnzupNT5HVQ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlI3dkACgkQdCsnp2M6
SWNJNw//Yd4/wBLqWHh8/sr4SIf8Iy3JQfVmIfAm3C28wuYErLHL8oJD0h/alyFw
fY1+6PSCDtg/q5Hq4ZKusq6gmTGpVVh24FhUrI5FG+X/oJ+tXdJyet+Y4rMUmTdF
y8c0YcDh0X+tN5lKQROnbTO0opgTbw0Zd1lVhG7tWh8vAtS5kRn3jSO5oaQtXxZi
IzN70soIjB2iMJwi9/EeGmICz7WsVGZDoopNA8t+tt+divljRfm2HNHYVxN9f1Zn
Ytbp9yrFAh7/XSKv0/4FjpRCP68sMymzX5wzgAhk/UWZc1bMb2y+8P34okWEYKjO
kaaB9VTBHen0tjlWJ5mNW6qS1b+XW2GRD9rRRSdWzpDQ30JTRqrFkq7Jycb+Ipiy
Gy+QblyICeElSjqLkfOggkixTaV5JiRaY552jjVjRM03cJRtZabpqbfeJgYpp7iJ
Lw50rYLyold8A23Vzx7YEj4+kENt4hu5rxNwLaigoqng5KSqcsxYvLSZusRNqm37
b/5sdn0ev8O+qGSEZ0ECZ8a0bN/aAbDLZjigmYBqRyxHlhVnrUUJAJj9Y040s8cC
bS2n9KbnvDW8qSz0l25tIzoLtkxbigwy+LHoicVTqYzJDctduVUefzLJE7/LXnHy
vg0Be5s4Fk0MD5s4wbjd1dEW8JMZdZ+pCnB66q9A7VrYGRPrDsU=
=GHiP
-----END PGP SIGNATURE-----

--N9jafWnzupNT5HVQ--

