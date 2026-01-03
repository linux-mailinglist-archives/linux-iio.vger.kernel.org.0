Return-Path: <linux-iio+bounces-27472-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95170CEFC89
	for <lists+linux-iio@lfdr.de>; Sat, 03 Jan 2026 09:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72ACE30133B0
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jan 2026 08:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFD32E54BD;
	Sat,  3 Jan 2026 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="lWyr6844"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.subdimension.ro (nalicastle.subdimension.ro [172.105.74.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD92DFA32;
	Sat,  3 Jan 2026 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.74.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767427230; cv=none; b=Rgy+RrxGJ2fsE8sZ2IODqDv5D6NtxIF+VFpHJ/dQFefuI+BAdy19+x3W57o0A09WMMnVwW+7JtH0FBcIhv/SL96pVY/n/c3puKHXiahtKYqoSNx/tgO09FURgJwCIONM5ons4CyOiSiQrstS8VwGJVaQq/MdLxo/JZikvCGEbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767427230; c=relaxed/simple;
	bh=JZnJ4gyUynf+J30sBNEu6DJ2euZrnh6O3tBwAExw0rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q8m0aFXh8lCe01DnDD0DNmFbUcAdnMBxmYZvuSHas3onaQ4idwqpNQaUTD7GRyYlC7JX2UmDgXAf1KjG3I0kv3FMwW9N3oegZsE8Yr3coO5M/GFLrGEKZjrl2eYpu32an2R2tEyqkcuFrfp6DVXgz/bNGXFXUyntyIuIDSp97aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro; spf=pass smtp.mailfrom=subdimension.ro; dkim=pass (2048-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b=lWyr6844; arc=none smtp.client-ip=172.105.74.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire.home.arpa (unknown [IPv6:2a02:2f0e:710:a300:e2d5:5eff:fed9:f1c4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 2272F160209;
	Sat, 03 Jan 2026 10:00:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=subdimension.ro;
	s=mail; t=1767427222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23PRcUbud6D/e7jm7WAHAM2kHkvTo6rhAG0Nux+vzgw=;
	b=lWyr6844yxATQXqGnSZlbaI2/3XFyFp49130CIok52be9NwFJCjj7I9w+8rbjgz5IaLLji
	2OFeO/wqpmedKDu962povvtJaQWOoUM5+KxX1eo4lWoYA3WpIDIO8Pcesezd9lRJuELOwL
	hDQerODnihz9zvDPfFsKcshGgK3cHqx2yIDZHiZxl3hrAqe+D+NG0zVof5mUtkGgZ8WQ/A
	deRSo27wt53ArnHfSst78jhHUIIrRfKNdlUpQb2eyoY5cezgVCBAuWLE10o5qFaD1vFaRz
	wURIaS2cJvn9EJpjCnonMQekBU/Rc42eY9/ctEOzyEXcUPJuuS4j8iESgE1uKA==
Date: Sat, 3 Jan 2026 10:00:19 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno S?? <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 06/14] iio: pressure: mprls0025pa: memset rx_buf before
 reading new data
Message-ID: <aVjMk4Z-VRaRYYeK@sunspire.home.arpa>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-6-b36a170f1a5c@subdimension.ro>
 <aUYqSUvA9fF_n-0Y@debian-BULLSEYE-live-builder-AMD64>
 <aUZdb9R9BLMfBpLJ@sunspire.home.arpa>
 <20251221182151.288a6da4@jic23-huawei>
 <aUjd5AJHohyW_kXM@lipo.home.arpa>
 <aUlQTxtWo0VUi4Yh@debian-BULLSEYE-live-builder-AMD64>
 <20251227143149.4d2f43fa@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="50v4DT4MasXCZ5an"
Content-Disposition: inline
In-Reply-To: <20251227143149.4d2f43fa@jic23-huawei>


--50v4DT4MasXCZ5an
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hello and a Happy New Year!

On Sat, Dec 27, 2025 at 02:31:49PM +0000, Jonathan Cameron wrote:
> On Mon, 22 Dec 2025 11:06:07 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
>=20
> > Hi Petre,
> >=20
> > On 12/22, Petre Rodan wrote:
> > >=20
> > > hello Jonathan,
> > >=20
> > > thank you for the review.
> > >=20
> > > On Sun, Dec 21, 2025 at 06:21:51PM +0000, Jonathan Cameron wrote: =20
> > > > On Sat, 20 Dec 2025 10:25:19 +0200
> > > > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > > >  =20
> > > > > Hello,
> > > > >=20
> > > > > On Sat, Dec 20, 2025 at 01:47:05AM -0300, Marcelo Schmitt wrote: =
=20
> > > > > > On 12/18, Petre Rodan wrote:   =20
> > > > > > > Zero out input buffer before reading the new conversion.
> > > > > > > Perform this operation in core instead of in the bus specific=
 code.
> > > > > > >=20
> > > > > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> > > > > > > ---
> > > > > > >  drivers/iio/pressure/mprls0025pa.c     | 2 ++
> > > > > > >  drivers/iio/pressure/mprls0025pa_i2c.c | 1 -
> > > > > > >  2 files changed, 2 insertions(+), 1 deletion(-)
> > > > > > >=20
> > > > > > > diff --git a/drivers/iio/pressure/mprls0025pa.c b/drivers/iio=
/pressure/mprls0025pa.c
> > > > > > > index 00b1ff1e50a8..7cc8dd0d8476 100644
> > > > > > > --- a/drivers/iio/pressure/mprls0025pa.c
> > > > > > > +++ b/drivers/iio/pressure/mprls0025pa.c
> > > > > > > @@ -16,6 +16,7 @@
> > > > > > >  #include <linux/mod_devicetable.h>
> > > > > > >  #include <linux/module.h>
> > > > > > >  #include <linux/property.h>
> > > > > > > +#include <linux/string.h>
> > > > > > >  #include <linux/units.h>
> > > > > > > =20
> > > > > > >  #include <linux/gpio/consumer.h>
> > > > > > > @@ -239,6 +240,7 @@ static int mpr_read_pressure(struct mpr_d=
ata *data, s32 *press)
> > > > > > >  		}
> > > > > > >  	}
> > > > > > > =20
> > > > > > > +	memset(data->rx_buf, 0, sizeof(data->rx_buf));   =20
> > > > > > This is unusual and I don't think it's needed for the SPI path.=
 Doesn't the I2C
> > > > > > subsystem overwrite the rx buffer with what it reads from the d=
evice?   =20
> > > > >=20
> > > > > I thought it's best practice to ensure that old conversions are n=
ot accidentally re-used in case the read operation fell thru the cracks.
> > > > > that's exactly why in this particular case the BUSY flag is imple=
mented on the hardware side.
> > > > >=20
> > > > > please tell me how a few byte memset() would be detrimental. =20
> > > >=20
> > > > We don't normally do this as old data isn't a potential leak of any=
thing
> > > > sensitive. =20
> > >=20
> > > from my point of view as someone writing drivers for chemistry lab in=
struments, stale readings are to be avoided at all costs.
> > > it's not about leaking sensitive data, it's about providing a warning=
 sign if the read operation fails silently.
> > >=20
> > > as an extreme (but fictional) example, a pilot looking at an altimete=
r would immediately recognize that something is wrong with it's pitot tube =
if it's giving out an off-scale static reading. if instead the output is be=
lievable (which would be the case when older readings are repeated due to a=
n uncaught intermittent read error) then there would be some uncertainty an=
d he would not know to definitely ignore the output of this particular inst=
rument and trust another one instead.
> > >=20
> > > the same logic applies to any instrument in a lab setting.=20
> > > a digital titration system that mixes multiple reagents needs to rely=
 on fresh conversions to know when to stop a process. some advanced sensors=
 even provide an incrementing conversion counter, others simply signal that=
 a measurement is ongoing/not fresh via a BUSY flag and these are designed =
so that the driver can avoid a stale reading.
> > >=20
> > > getting back to my driver, some pressure sensor series have a latch-u=
p sensitivity and they misbehave during reads in various ways under certain=
 conditions. I understand that you say that silent fails are unlikely but I=
'd like to keep the memset, for peace of mind. =20
> >=20
> > I agree with you that old conversions should not be accidentally re-use=
d nor
> > errors silently be ignored. But, to me, memset the read buffer to zero =
looks
> > like we don't trust the underlying I2C and SPI layers. In that case, we=
 should
> > fix data read in those subsystems (if there is anyhting be fixed there).
> > Though probably unlikely scenario to happen, how would one trust the se=
nsor
> > reading in a scenario where the extected measurement would be close to =
zero.
>=20
> There are two different ways to get stale data in these buffers.
> 1) read fail. Those we absolutely should trust to be handled correctly by=
 lower layer
>    with errors reported and the data therefore not used.  Whether it is s=
tale or random
>    garbage doesn't really matter.  0 is often a perfectly valid reading s=
o no extra
>    info from seeing that in the buffer.

for this sensor a raw conversion of 0 is out of bounds. valid values are be=
tween
 output_min and output_max:

	[MPR_FUNCTION_A] =3D { .output_min =3D 1677722, .output_max =3D 15099494 },
	[MPR_FUNCTION_B] =3D { .output_min =3D  419430, .output_max =3D  3774874 },
	[MPR_FUNCTION_C] =3D { .output_min =3D 3355443, .output_max =3D 13421773 },

I expect that the user will recognize such an abnormal reading.

for the SPI transfer specifically there is a latch-up scenario in which the=
 MOSI
signal is being clamped down by the sensor in sync with SCLK [1].
I do not know how all SPI controllers act when MOSI is forced to GND, thus
 provided the memset() for a hypothetical scenario in which the SPI control=
ler
 just resets during the xfer (due to a brownout) and if this condition is n=
ot
  recognized by the low level spi layer (I see no way to test this).

[1] https://e2e.ti.com/support/processors-group/processors/f/processors-for=
um/1588325/am3358-spi-tx-data-corruption
(my guess is that ABP2 and MPR series of sensors share the same silicon imp=
lementation)

> 2) Changes in configuration that move the holes around or create some.  T=
his is the
>    more interesting corner.  I don't think the stale data argument applie=
s because
>    any software reading the data in the holes and doing anything with it =
is inherently
>    buggy (plus as above, 0 is almost always a valid reading!)  Some drive=
rs will
>    even read other data into those holes (checksums etc are common).
>=20
> So I don't see either as being a particularly problem here.  I don't mind=
 the buffer
> being cleared on each read but it doesn't to me seem necessary for any co=
rrectness
> or security related reasons which are the two cases we need to make sure =
we clear
> data for.

clamping an output signal to GND smells to me like 'undefined behaviour' wh=
en
one looks at a large number of SPI controller implementations and this mems=
et
would provide an early warning, at no cost.

> Jonathan
>=20
> >=20
> > My suggestion is to look for a way of ensuring the transfer timing requ=
irements
> > specified in data sheet page 18 [1]. See the dummy delay transfer sugge=
stion to
> > patch 09.
> >=20
> > [1]: https://4donline.ihs.com/images/VipMasterIC/IC/HWSC/HWSC-S-A001603=
6563/HWSC-S-A0016036563-1.pdf?hkey=3DCECEF36DEECDED6468708AAF2E19C0C6

yes, thank you Marcelo. your delay xfer idea works and it will be part of V=
2.
but that issue is completely unrelated to the memset modification.

best regards,
peter

> > > > However in most drivers this only spills out at all as
> > > > a result of say a change in configured channels and is normally har=
mless
> > > > as userspace knows to ignore stuff in the gaps anyway.  If there is
> > > > another cases here (you mention the busy flag) then add a comment o=
n why
> > > > it makes sense. I don't in general want drivers to start doing this=
 as
> > > > it is in the fast path and sometimes the memset is non trivial (her=
e it
> > > > is probably irrelevant as the buffer is small).
> > > >=20
> > > > Thanks,
> > > >=20
> > > > Jonathan =20
>=20

--=20
petre rodan

--50v4DT4MasXCZ5an
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJPBAABCgA5FiEEGiKYHD4NvFCkTqJ3dCsnp2M6SWMFAmlYzI0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEHQrJ6djOkljq6AQAJlQPMdxlLQvZTULZOBc
9gxrzlNwZQbe623PB/t14LSBH+Ue+E1usaznl9UDz9KAmJRgRXEWCZrGhNIQAu/P
VC6sZREoXLYmXrcjK9aCobcZXtl/RI3u8hOZ5RTbODEF1SRLizGi5cbLYqvS7pa9
m8d8fZoBy1m6RW1OfK+j1eT0/OJMRajSjLf681vAH+pDjWgP29a2tCnzgQ01FLsn
yl6fyCvA+N5j1WvxoESlrZOeVjtXJoNPSH6MegVy5uDES4JlJ3H4WFZ7z0NuvYMi
R152hPjAx7RV4fNwFnIVGQXTjzZUtb13q3UwbVNFBpmMEHdeoNckp7qnd/xQAR5H
s9zAcxiA+j5pzOQ6TX0aSZe0DM/V1oST9sC+yynEi/Xsx2nZkHWzpkk/pwRQNq0A
tEmymGLwAHSWWwEPbazpn9Krfk3kLY6YnRXaz6ZVwfpnrPlV8y0N+KhT80ZA9Qf2
S7/DkwpAHmL85ghr4fuGiXDwr/DjUO9GzidpagWvJ/lIWx1V7b3zD61NUlGAll9O
Bv+0lChZt3iaCICihQ+0s17bivnquKAHed1junatsqRRNSqginnoLhLe6CDHhbdS
lzNy2kTo8Zu0dkXJS3gq+JJUg5meaN2t35JID3teX+ywxhGHZYdz3jf2WdCQ5aUL
T0t/I0UBQaC39/KqwNYpMQqi
=QMDt
-----END PGP SIGNATURE-----

--50v4DT4MasXCZ5an--

