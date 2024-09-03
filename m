Return-Path: <linux-iio+bounces-9094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704E796A75D
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 21:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA313B227E1
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 19:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50DD1D7E2A;
	Tue,  3 Sep 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKKoRkt7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDC91D7E20;
	Tue,  3 Sep 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391713; cv=none; b=hNsrtBsXfWpm8IvIlI3FoTu4aaun2jP3E5zEO90R8m0usZ+7mL053p0jRZEvDpPhSSynE6fTcKlW99Ivq4tYtwtYt4fEFMmbbLlPlVNXIxdKEF7EHXSEH+XNMSC0yoH979Fw62+lrjnNSu1rGat6faBP2eJ+7VfFIjbhzL7C3lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391713; c=relaxed/simple;
	bh=kGWtPEPIJLR0935+d9B8JgXALaeJFuBuVV22oeFjut4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qtyayKtFnT4+xtHEWYOxA5K58w7XMGAXNT8gs/uPQ/ZpN6PTUW21wNTnDi9Oz07GRbvdrKipeghkQxRalH6E8OwAzLVAK3sS1Ec+8xlbRByAo3ezXr1REX+Y9B/tLWVCLqF7gUBdFntRR/BqJgKRfeucc45FRYCcOIzZLOPj1is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKKoRkt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A01C4CEC4;
	Tue,  3 Sep 2024 19:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391712;
	bh=kGWtPEPIJLR0935+d9B8JgXALaeJFuBuVV22oeFjut4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VKKoRkt7BpZKkO60WHE/DHEUdvGHiPehiv/5+AqMWz54bR8BZ1ngbFxqHuxuCyG2e
	 4D+vYvGUGVOWv6OLMa0wqPgkM9oMAVQr+5j8pbBtKNFEsAITMj72nzxuB/NfwFu0zf
	 rg384Jg/MmokF/+ZOASI3H2xEyrZgbQXilg0VOoP1fZeKDgkXn8U4u/Z2yPi6tVmcA
	 0BxMuxDJQe5sdXw/mv1EH/seUldMS8JFqraaLm18dfJwqZLEWXiNlJ1cL8JU/XIAb2
	 m4teLWNzECWGryUb/sikNVN9c4O3dj0RcaQcCRZgouXe4OS12Jc9jQwnlW5JiH7KEZ
	 WZLs8kmeoHlHw==
Date: Tue, 3 Sep 2024 20:28:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Subject: Re: [PATCH RFC 7/8] iio: dac: ad3552r: add axi platform driver
Message-ID: <20240903202823.786e930c@jic23-huawei>
In-Reply-To: <421d7967-e9e4-4207-a9de-db309ea482b0@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	<20240829-wip-bl-ad3552r-axi-v0-v1-7-b6da6015327a@baylibre.com>
	<20240831131322.494119f3@jic23-huawei>
	<421d7967-e9e4-4207-a9de-db309ea482b0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Sep 2024 10:17:35 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> Hi Jonathan,
>=20
> On 31/08/24 2:13 PM, Jonathan Cameron wrote:
> > On Thu, 29 Aug 2024 14:32:05 +0200
> > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > =20
> >> From: Angelo Dureghello <adureghello@baylibre.com>
> >>
> >> Add support for ad3552r AXI DAC IP version.
> >>
> >> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com> =20
> > Hi Angelo
> >
> > To me this feels like the interface is much closer to SPI + SPI offload
> > than to a conventional IIO backend on the basis it carries the configur=
ation
> > path as well.
> >
> > Can we see if it can be fitted into that model?  You will need to define
> > a new bus type etc for it but should be fairly simple given constrained
> > setup (at least today!)
> >
> > That will resolve a bunch of questions around the binding as well. =20
>=20
> thanks for all the feedbacks.
>=20
> I see, spi offload may have more sense but as of now looks like moving to
> AXI SPI engine instead of AXI DAC would require quite a lot of work from =
the
> ADI HDL guys and also then, for me some work reworking all this stuff.
>  From an initial discussion with Nuno and David, we was oriented to use t=
he
> iio backend for the current HDL, so at least for this chip at this stage=
=20
> would
> be good, if possible, to stay this way.

Superficially, even with the existing IP it feels to me like it's just
a qspi controller + an offload that happens not to need much programming.

You'd pass that offload the spi message structure etc and it would 'notice'
that it corresponds to what it has in hardware and then use that.

For register reads it looks like a simple (Q)SPI bus controller anyway.

So I'm not sure any real changes are needed in the IP to map it
in a more standard way as as a device on a bus.

Note though that key here may be how we do the dt-binding, rather than
what the code does (we can change the internals of the driver later
if we like).

If you built a binding that looked like an spi bus + offload and
could we bind a backend etc as you do currently?=20

Might require a bit of juggling to make it work.


>=20
>=20
> > Jonathan
> > =20
> >> diff --git a/drivers/iio/dac/ad3552r-axi.c b/drivers/iio/dac/ad3552r-a=
xi.c
> >> new file mode 100644
> >> index 000000000000..98e5da08c973
> >> --- /dev/null
> >> +++ b/drivers/iio/dac/ad3552r-axi.c
> >> @@ -0,0 +1,572 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Analog Devices AD3552R
> >> + * Digital to Analog converter driver, AXI DAC backend version
> >> + *
> >> + * Copyright 2024 Analog Devices Inc.
> >> + */
> >> +
> >> +#include <linux/bitfield.h>
> >> +#include <linux/delay.h>
> >> +#include <linux/gpio/consumer.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/backend.h>
> >> +#include <linux/of.h> =20
> > Why?  Probably want mod_devicetable.h =20
>=20
>=20
> with mod_devicetable.h in place of of.h i get
>=20
> drivers/iio/dac/ad3552r-axi.c:272:9: error: cleanup argument not a functi=
on
>  =C2=A0 struct fwnode_handle *child __free(fwnode_handle) =3D NULL;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~
That's not in of.h either
add linux/property.h as well.

>=20

...

> >> +static int ad3552r_axi_setup(struct ad3552r_axi_state *st)
> >> +{

> > =20
> >> +	u32 val, range;
> >> +	int err;
> >> +
> >> +	err =3D ad3552r_axi_reset(st);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	err =3D iio_backend_ddr_disable(st->back);
> >> +	if (err)
> >> +		return err;
> >> +
> >> +	val =3D AD3552R_SCRATCH_PAD_TEST_VAL1;
> >> +	err =3D iio_backend_bus_reg_write(st->back, AD3552R_REG_ADDR_SCRATCH=
_PAD,
> >> +					&val, 1); =20
> > as per earlier review, I'd pass an unsigned int instead of a void *
> > Then you can avoid the dance with a local variable. =20
> void * was chosen thinking to future busses, please let me know if
> it can stay this way.
I'd not bother future proofing that much.  If you think > 32 bit is
likely use a u64.

> >> +	if (err)
> >> +		return err;

