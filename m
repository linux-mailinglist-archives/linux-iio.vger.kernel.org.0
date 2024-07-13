Return-Path: <linux-iio+bounces-7582-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B409304E6
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DC4B212E9
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6294CB2B;
	Sat, 13 Jul 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tvjaBb+I"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC03C101E6;
	Sat, 13 Jul 2024 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865389; cv=none; b=iSSYM9MjGtyXcV2M01HMkB7ubyxjt9h/xaE+DywjdMFYDt1pbafyIs9oSI19c9dmmRg+qypP7kbLBc/4uCQaEF+Hh8xvP6VUKHdZLwk2SLjSCXCLeZbheH8+36hBuy68YNpkF57NusQlPA2XPipz/8CyUE/P0yRauXvK1AGpovg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865389; c=relaxed/simple;
	bh=gWbTzZXIi2BBtYYNsSaJA9ZU5XfKqUUJnGNEK1iNV0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPpn1BFKbTUFVvml5zaabb6RElwbtr+lXNpisUD0NtoLWcWhv7Ha/VeQJy85dhZE5KwtpisvU8OE84tIWTp0rffLue1UG58e43XEmtLwbBzS3s1EqkBa2pPg9sQsPtmTKBve3C23pAzRwq7qstznj9dOBuBYsncWtk6U8d0UuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tvjaBb+I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80551C32781;
	Sat, 13 Jul 2024 10:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720865389;
	bh=gWbTzZXIi2BBtYYNsSaJA9ZU5XfKqUUJnGNEK1iNV0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tvjaBb+ISFqW6RyVhjTTqT24ALXL9n2o92eImURh96BTHAeGaX7JK5WOPZOtJVsre
	 3AN74qlXDpeBTgHLyqiK+e1qDpVYDuwo/pJfHpe8iDt8ogFUhc2tnWAVMo/o16Eq7i
	 E7Lgrh2QdNOEI1+Bq7C7EB4IxRyWrrEyrE5niJDCAmJYwHP0xoq/Q7gbU5TTGUP/2W
	 gi2qeogSW3e3Q8D6N8gdC7rTOxlzZ4o3pYMROwMjxejzJltmk4bYGxmgfoFNrtYsip
	 y+isUMXSmg1hRsMfsA/bKL13xfw5OVMuSCJJvffzDxqJzARbjGzOOnQnrAhwY9rXH7
	 1z6AqC3otwb8A==
Date: Sat, 13 Jul 2024 11:09:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Marius.Cristea@microchip.com, robh@kernel.org, krzk+dt@kernel.org,
 lars@metafoo.de, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: add support for pac1921
Message-ID: <20240713110939.6b359e7b@jic23-huawei>
In-Reply-To: <668bed8e65d4f_6e037024@njaxe.notmuch>
References: <20240703-iio-pac1921-v1-0-54c47d9180b6@gmail.com>
	<20240703-iio-pac1921-v1-2-54c47d9180b6@gmail.com>
	<SN6PR11MB3167C48F19120E35862316FA99DE2@SN6PR11MB3167.namprd11.prod.outlook.com>
	<a67e4c0bf2c3839694b60cb96bbc43170fbb2f36.camel@microchip.com>
	<668bed8e65d4f_6e037024@njaxe.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Jul 2024 15:45:50 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Marius.Cristea@ wrote:
> >=20
> >=20
> >   Hi Matteo,
> >=20
> >    Thank you very much for helping us adding PAC1921 support. I'm also
> > developing a similar driver and I could share the code with you to make
> > the driver better.
> >=20
> >    Also I have a few review comments, please, see bellow:
> >=20
> > Best regards,
> > Marius =20
>=20
> Hi Marius,
>=20
> Thanks for your feedback, this is indeed very helpful, as it would be if =
you
> shared your code.
>=20
> I addressed some of your comments below in patch v2 thread, replying to
> Jonathan [1]. If you have more comments about those points please reply o=
n that
> thread.
>=20
> [1]: https://lore.kernel.org/linux-iio/668bec2a8b23a_6e037017@njaxe.notmu=
ch
>=20
> See also my comments below.
>=20
> > On Wed, Jul 03, 2024 at 03:34:34PM +0200, Matteo Martelli wrote:
> >=20
> >  =20
> > > +
> > > +/* pac1921 regmap configuration */
> > > +static const struct regmap_range pac1921_regmap_wr_ranges[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_reg_range(PAC1921_REG_GA=
IN_CFG, PAC1921_REG_CONTROL),
> > > +};
> > > +static const struct regmap_access_table pac1921_regmap_wr_table =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .yes_ranges =3D pac1921_regmap_=
wr_ranges,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n_yes_ranges =3D ARRAY_SIZE(pa=
c1921_regmap_wr_ranges),
> > > +};
> > > +static const struct regmap_range pac1921_regmap_rd_ranges[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_reg_range(PAC1921_REG_GA=
IN_CFG, PAC1921_REG_CONTROL),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regmap_reg_range(PAC1921_REG_VB=
US, PAC1921_REG_VPOWER + 1),
> > > +};
> > > +static const struct regmap_access_table pac1921_regmap_rd_table =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .yes_ranges =3D pac1921_regmap_=
rd_ranges,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .n_yes_ranges =3D ARRAY_SIZE(pa=
c1921_regmap_rd_ranges),
> > > +}; =20
> > I know that the regmap is the way forward, but the PAC devices are more
> > efficient if bulk read is done.
> > =20
> I think performances depends on the use case, for example if the user is
> interested in only one type of measurement I don't think reading all regi=
sters
> result in a performance gain. Also consider that there are 8 registers of
> accumulators that are not currently exposed by the driver but that would =
be read
> anyway, so I am not sure it would result in a performance gain either. I =
would
> leave it as it is right now to keep the implementation simple and maybe e=
xtend
> it in the future in case performance gains become obvious and necessary f=
or most
> use cases. Also consider that regmap supports bulk reads.

Usual trick with this stuff is to apply some heuristics ideally based on
what is reasonable on a test platform.  If we are going to read x% of regis=
ters
then bulk read them all, if it's less than %x do separate reads.

However, it does add maintenance burden, so there has to be a significant
advantage. Many userspace apps want all or almost all the data though
so we often optimise for that at the cost of reading single channels
(through the buffer interface anyway).

> >
> > Also when you are reading all values at
> > the same time, the Voltage, Current and the Power numbers will came
> > from the same sampling time and they will be correlated to each other.
> >  =20
> I think that there is no guarantee that the user would always request two
> successive raw readings, like Voltage and Current, within the same integr=
ation
> period. So for the second reading all registers may be read again and the=
 two
> values might not be correlated as well. Also consider that the measuremen=
ts are
> kept in the device registers until a new integration is complete, so if t=
wo
> registers are read consecutively within the same integration period they =
would
> be correlated.

We only usually care about correlation of channels when using the buffered
interface.  There are a few exceptions such as quaternions where they have
no meaning as separate values and where we are computing another value from
the read out of several physical channels (light sensors etc).

> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 case PAC1921_CHAN_POWER: {
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Power=
 scale factor in mW: =20
> >=20
> > I think the scale here should be in microWatts. We have (mA)*(mV)
> >  =20
> Documentation/ABI/testing/sysfs-bus-iio states it should be in milliwatts:
>=20
> What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_raw
> KernelVersion:	4.5
> Contact:	linux-iio@vger.kernel.org
> Description:
> 		Raw (unscaled no bias removal etc.) power measurement from
> 		channel Y. The number must always be specified and
> 		unique to allow association with event codes. Units after
> 		application of scale and offset are milliwatts.

These units tend to be copied from hwmon.  With hindsight we should just
have gone with volts / amps and watts but that's history now.

Jonathan

