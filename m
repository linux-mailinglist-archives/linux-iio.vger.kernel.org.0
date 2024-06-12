Return-Path: <linux-iio+bounces-6193-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B01905214
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3472BB235B8
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 12:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2147B16F90B;
	Wed, 12 Jun 2024 12:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp6JVeHx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B8916EBF0;
	Wed, 12 Jun 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194032; cv=none; b=P0CnkfMsaanfAMUzepyHrydH76Pt6PxBH1uPc3D45ANRu5C4WaBOYcXTCWZLNOg/264T7+S+tb5KEcoYNidS92SoHfdGFTgPkhuO27frPkBATJUgP1hYjZcwH0BjT7K0Tijb7x/Z6Zkw99ZczmZEQzD4ToPkbnrAQ7a2dUv0xOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194032; c=relaxed/simple;
	bh=++fbo4SuBu2Z2PZvsQACpDLh5fMt0JZNidPjcHb7tvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cpFUXvp47esDwTO43ItlUtxyoH0SZhNd1fJxISjCln2JE4lUAe8o38MxECbHQvjPiFi+flka6Qs9mEK1sYfNwoNPv1xghh74xlhbPagqfadzb0fIQPwzNoaXhM6Fw+o1pC3+y57ssx6y9i+geuxMqIbfSbmAGJGkNpP5n+zXV8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp6JVeHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0929BC3277B;
	Wed, 12 Jun 2024 12:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718194032;
	bh=++fbo4SuBu2Z2PZvsQACpDLh5fMt0JZNidPjcHb7tvQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wp6JVeHxvI/2hX8RgqVmKY6HCOkL6GBIUSpVtE4ZBPCNOIWjt7wMc4EzW+AovuGYo
	 BYgWN246wX4siFRlP/82oipQ9cCHXkdbZHoaXEnBj4yeOV+7A4SO2yme6mddiR+KJV
	 tGSTqqGqAFTd12J19UBfDWFVtYZSsffh577xq+ydXKZzTurH/DrgHOpZfd4mWLdiS3
	 9TxKDvnB7m8o/aPsG++W3ou+C253+JQcPB6UXDkVDQLdIyTBFvRF+iWErOI01tH696
	 LfYQ/M/ylpttQi1z6BrqupfC5+1q2iBW3iD+BtamfaYCsQ4Mf1Gg4LpgVJHgn3kyAU
	 i4FKQqtYqaPdA==
Date: Wed, 12 Jun 2024 13:07:07 +0100
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: frequency: adf4350: add clk provider
Message-ID: <20240612-traverse-scion-1c5fd444f9c2@spud>
References: <20240612104554.66851-1-antoniu.miclaus@analog.com>
 <20240612104554.66851-2-antoniu.miclaus@analog.com>
 <b9c974265111887e7a944cb9e854e86cc8bcd47c.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wmb5i0D1Mc1BcH67"
Content-Disposition: inline
In-Reply-To: <b9c974265111887e7a944cb9e854e86cc8bcd47c.camel@gmail.com>


--wmb5i0D1Mc1BcH67
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 01:54:07PM +0200, Nuno S=E1 wrote:
> Hi Antonium
>=20
> On Wed, 2024-06-12 at 13:45 +0300, Antoniu Miclaus wrote:
> > Add clk provider feature for the adf4350.
> >=20
> > Even though the driver was sent as an IIO driver in most cases the
> > device is actually seen as a clock provider.
> >=20
> > This patch aims to cover actual usecases requested by users in order to
> > completely control the output frequencies from userspace.
> >=20
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v3:
> > =A0- use container_of to directly access the adf4350_state structure.
> > =A0drivers/iio/frequency/adf4350.c | 118 ++++++++++++++++++++++++++++++=
++
> > =A01 file changed, 118 insertions(+)
> >=20
> > diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/ad=
f4350.c
> > index 4abf80f75ef5..f716f744baa9 100644
> > --- a/drivers/iio/frequency/adf4350.c
> > +++ b/drivers/iio/frequency/adf4350.c
> > @@ -19,6 +19,7 @@
> > =A0#include <linux/gpio/consumer.h>
> > =A0#include <asm/div64.h>
> > =A0#include <linux/clk.h>
> > +#include <linux/clk-provider.h>
> > =A0
> > =A0#include <linux/iio/iio.h>
> > =A0#include <linux/iio/sysfs.h>
> > @@ -36,6 +37,9 @@ struct adf4350_state {
> > =A0	struct gpio_desc		*lock_detect_gpiod;
> > =A0	struct adf4350_platform_data	*pdata;
> > =A0	struct clk			*clk;
> > +	struct clk			*clkout;
> > +	const char			*clk_out_name;
> > +	struct clk_hw			hw;
> > =A0	unsigned long			clkin;
> > =A0	unsigned long			chspc; /* Channel Spacing */
> > =A0	unsigned long			fpfd; /* Phase Frequency Detector */
> > @@ -61,6 +65,8 @@ struct adf4350_state {
> > =A0	__be32				val __aligned(IIO_DMA_MINALIGN);
> > =A0};
> > =A0
> > +#define to_state(_hw) container_of(_hw, struct adf4350_state, hw)
> > +
>=20
> nit: to_adf4350_state() would be neater...
>=20
> > =A0static struct adf4350_platform_data default_pdata =3D {
> > =A0	.channel_spacing =3D 10000,
> > =A0	.r2_user_settings =3D ADF4350_REG2_PD_POLARITY_POS |
> > @@ -264,6 +270,10 @@ static ssize_t adf4350_write(struct iio_dev *indio=
_dev,
> > =A0	mutex_lock(&st->lock);
> > =A0	switch ((u32)private) {
> > =A0	case ADF4350_FREQ:
> > +		if (st->clkout) {
> > +			ret =3D clk_set_rate(st->clkout, readin);
> > +			break;
> > +		}
>=20
> So, apparently you forgot or decided otherwise to not go with the suggest=
ion of
> not including the IIO interface (at least he channel one - debugfs could =
be
> maintained I guess) or with the more in the middle approach Michael sugge=
sted.
> Just not allowing ADF4350_FREQ and ADF4350_FREQ_REFIN.
>=20
> Hence, I would expect at least some justification to keep the above in yo=
ur v3
> changelog. Also note that keeping ADF4350_FREQ_REFIN while being a clock
> provider seems pointless and maybe even be wrong (as the clock framework =
should
> take care of the parent clock). This also brings another question... see =
below
>=20

I think also there was a request to include the clk list and
maintainers. It's possible that Stephen might want something like the
auxbus to be used here so that the clock code ends up in the clock
subsystem.

Thanks,
Conor.


--wmb5i0D1Mc1BcH67
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZmmPawAKCRB4tDGHoIJi
0vynAQCD/d0QgoTvtycKI0YWWbxLWVEG16TQRnF50K9GGEdTaQEAzTwSf8Zls9Sz
zzAZyEwz4zs8xzqmIROcrcyIpxAkdQ8=
=HaFQ
-----END PGP SIGNATURE-----

--wmb5i0D1Mc1BcH67--

