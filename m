Return-Path: <linux-iio+bounces-6182-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8A2904261
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 19:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30AA11F24BB3
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2024 17:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF3D3FB83;
	Tue, 11 Jun 2024 17:26:59 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FEA14A96;
	Tue, 11 Jun 2024 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718126819; cv=none; b=Mm11oOuZIk4ivHcsc4G6iGvzdeKtHxAOo+IARCtG37cRpQMhuWfRbirJ0YkZIx1PP/k7LbV5LpMDMwT8YgYg7i870ZLrIFFzjYkVj+uXngw/A/IAfi7BbnM2En0a3pb19GZ0+O2v5mPEHzUQG1RCEbl8DxOqzg+wShKhCE0uWCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718126819; c=relaxed/simple;
	bh=PQLwwDGRqqF55xd7XeWM0poiiX+qWfO3D3NvJaY17s4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8H1Ik2SGQrbBgZTaIf+s53Z6sN8yKvHiFF2tOEycfS8O54GNrgtDFTh9O1pFZOBaTPhwpHYCy9PBHDOGu+/OJ8LEFekvpeB6pdh/PXCM9sC3M1GGsjiEo+Lmv01VD5qZWk0vZfgpeGypVXsjQVnTt7wXwspv6EQ5EdZId2Ct50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VzFpZ4Fryz67lCJ;
	Wed, 12 Jun 2024 01:21:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BD291404FC;
	Wed, 12 Jun 2024 01:26:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Jun
 2024 18:26:53 +0100
Date: Tue, 11 Jun 2024 18:26:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	=?ISO-8859-1?Q?Jo=E3o?= Paulo =?ISO-8859-1?Q?Gon=E7alv?= =?ISO-8859-1?Q?es?=
	<jpaulo.silvagoncalves@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, =?ISO-8859-1?Q?Jo=E3o?= Paulo
 =?ISO-8859-1?Q?Gon=E7alves?= <joao.goncalves@toradex.com>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>, Francesco
 Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1119: Add driver
Message-ID: <20240611182652.00005816@Huawei.com>
In-Reply-To: <20240610115909.GA27057@francesco-nb>
References: <20240606163529.87528-1-francesco@dolcini.it>
	<20240606163529.87528-3-francesco@dolcini.it>
	<20240609115234.20e08840@jic23-huawei>
	<20240610115909.GA27057@francesco-nb>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 10 Jun 2024 13:59:09 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello Jonathan,
> thanks for the review.
>=20
> On Sun, Jun 09, 2024 at 11:52:34AM +0100, Jonathan Cameron wrote:
> > On Thu,  6 Jun 2024 18:35:29 +0200
> > Francesco Dolcini <francesco@dolcini.it> wrote:
> >  =20
> > > From: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> > >=20
> > > The ADS1119 is a precision, 16-bit, analog-to-digital converter (ADC)
> > > that features two differential or four single-ended inputs through a
> > > flexible input multiplexer (MUX), rail-to-rail input
> > > buffers, a programmable gain stage, a voltage reference, and an
> > > oscillator.
> > >=20
> > > Apart from normal single conversion, the driver also supports
> > > continuous conversion mode using a triggered buffer. However, in this
> > > mode only one channel can be scanned at a time, and it only uses the =
data
> > > ready interrupt as a trigger. This is because the device channels are
> > > multiplexed, and using its own data ready interrupt as a trigger guar=
antees
> > > the signal sampling frequency.
> > >=20
> > > Datasheet: https://www.ti.com/lit/gpn/ads1119
> > > Signed-off-by: Jo=E3o Paulo Gon=E7alves <joao.goncalves@toradex.com>
> > > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com> =20
> >=20
> > A few more comments inline. Some of these I missed in the first
> > versions - sorry about that.  Takes a few passes to pick up
> > on everything unfortunately.
> >  =20
> > > diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads111=
9.c
> > > new file mode 100644
> > > index 000000000000..ea0573f07279
> > > --- /dev/null
> > > +++ b/drivers/iio/adc/ti-ads1119.c
> > > @@ -0,0 +1,850 @@ =20
>=20
> ...
>=20
> > > +
> > > +static int ads1119_cmd(struct ads1119_state *st, unsigned int cmd)
> > > +{
> > > +	dev_dbg(&st->client->dev, "cmd: %#x\n", cmd);
> > > +
> > > +	return i2c_smbus_write_byte(st->client, cmd); =20
> > I'm not a fan of tiny wrappers to add debug info.
> > The i2c core has trace points that let you get to the relevant data. Be=
tter
> > to use those for debug and flatten this code so we
> > see the actual bus accesses inline. =20
>=20
> Fine on removing the debug prints, we'll do.
>=20
> However ads1119_cmd_rdata() and ads1119_update_config_reg() wrappers are
> making the error handling in the caller easier.

for rdata() only 2 calls so not bad to add the error handling in those
locations.

The update one is more justifiable given the read modify write and that
it is reasonably common.  So perhaps just keep that one, but it is
odd that your cmd_wreg() hard codes the address and cmd_rreg() doesn't.
If keeping the update function I would pass in the register address.

Maybe better would be to just cache the contents of the cmd register.
Then you can avoid a bunch or RMW and make them simply a write.

Wrapping that up makes sense as both a register write and on success
update of a cached value.

Pity this isn't quite all register based as if it was I'd say just
use regmap which gives you all the accessors for free.


>=20
> Either we remove only ads1119_cmd/ads1119_cmd_wreg or we keep them all
> for orthogonality. Both works for me, just let me know if you agree and
> which option do you prefer. Personally I would keep them all without
> debug prints.

I'd drop them, but have a update_config_reg() that uses a cached
value to avoid the reads and updates that cached value on the write
succeeding.  That one is non trivial.

>=20
> > > +
> > > +	return read_poll_timeout(ads1119_data_ready,
> > > +				 data_ready,
> > > +				 (data_ready =3D=3D true),
> > > +				 wait_time,
> > > +				 ADS1119_MAX_DRDY_TIMEOUT,
> > > +				 false,
> > > +				 st); =20
> > Over wrapped. Aim for closer to 80 chars. =20
>=20
> I'll do.
> Do you have any rules on the IIO subsystem driver? IOW is it fine to
> have line slightly longer than 80chars if this improves readability ?

Absolutely.  Good to keep to 80 chars except:
1) String involved - don't break it up as can't grep - those can go way
   over 80 chars
2) Non trivial readability improvement.  Then stay under 100 chars.
   If you need to go over that, normally can use a local variable
   or similar to avoid it.


>=20
> Francesco
>=20
>=20


