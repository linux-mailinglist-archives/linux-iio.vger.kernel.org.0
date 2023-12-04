Return-Path: <linux-iio+bounces-589-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60E580389B
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 616C51F2125D
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA662C1AB;
	Mon,  4 Dec 2023 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDy1RVFr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7932511F;
	Mon,  4 Dec 2023 15:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403E4C433C8;
	Mon,  4 Dec 2023 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701703288;
	bh=73pAaB3mi7c07UkmN0pF09RndH2hCE1ns/C5OrUjhHE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lDy1RVFrrYKs9mpINAj6ruU5nicvceF9qfesxbreDv5Ot6A8bB6AK6xSR5dYq2e4V
	 ryMyekOp1QWlMK+tgSDcGtOzFjHky1bvbW1VptgSzUvhGji5mWOxi1S8YAPoNnFaGr
	 21Xv8Qp1rjs/XzgGDfw9BlE5GxAOwjogqRyZ+wHya6eF6X5M84pkRmQoSyfX1i65nP
	 7QwKx89Vty9oTA4m9+pi/UBmUQ6dOWgASAwVaxLPpBPBZJ3th+8vTY5q3B3oPkU+yk
	 KzBx5WKDx2m1dy5FfO8xIlqkP1XW+XM5uMQDKTkg6hA8RNADLExl7fnrqwTPxXFCri
	 boSYoVFptp4cA==
Date: Mon, 4 Dec 2023 15:21:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, Olivier MOYSAN <olivier.moysan@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 06/12] iio: adc: ad9467: add mutex to struct
 ad9467_state
Message-ID: <20231204152120.71455f40@jic23-huawei>
In-Reply-To: <2343dacb0ec0a4878c8e41748ed6e586ff53ccd4.camel@gmail.com>
References: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
	<20231121-dev-iio-backend-v1-6-6a3d542eba35@analog.com>
	<CAMknhBHsFS5p-_250WRmkH2za+QPV6WyKNfgD-E1W8=HV3W3fg@mail.gmail.com>
	<2343dacb0ec0a4878c8e41748ed6e586ff53ccd4.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Dec 2023 09:49:38 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-11-30 at 15:50 -0600, David Lechner wrote:
> > On Tue, Nov 21, 2023 at 4:17=E2=80=AFAM Nuno Sa via B4 Relay
> > <devnull+nuno.sa.analog.com@kernel.org> wrote: =20
> > >=20
> > > From: Nuno Sa <nuno.sa@analog.com>
> > >=20
> > > When calling ad9467_set_scale(), multiple calls to ad9467_spi_write()
> > > are done which means we need to properly protect the whole operation =
so
> > > we are sure we will be in a sane state if two concurrent calls occur.
> > >=20
> > > Fixes: ad6797120238 ("iio: adc: ad9467: add support AD9467 ADC")
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > ---
> > > =C2=A0drivers/iio/adc/ad9467.c | 6 +++++-
> > > =C2=A01 file changed, 5 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> > > index 04474dbfa631..91821dee03b7 100644
> > > --- a/drivers/iio/adc/ad9467.c
> > > +++ b/drivers/iio/adc/ad9467.c
> > > @@ -4,7 +4,7 @@
> > > =C2=A0 *
> > > =C2=A0 * Copyright 2012-2020 Analog Devices Inc.
> > > =C2=A0 */
> > > -
> > > +#include <linux/cleanup.h>
> > > =C2=A0#include <linux/module.h>
> > > =C2=A0#include <linux/mutex.h> =20
> >=20
> > Ah, the case of the misplaced header from the previous patch is solved.=
 :-)
> >  =20
>=20
> Yeps, it needs to be in this patch :)
>=20
> > > =C2=A0#include <linux/device.h>
> > > @@ -122,6 +122,8 @@ struct ad9467_state {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 output_mode;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct gpio_desc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 *pwrdown_gpio;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* protect against concurrent a=
ccesses to the device */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct mutex=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 lock;
> > > =C2=A0};
> > >=20
> > > =C2=A0static int ad9467_spi_read(struct spi_device *spi, unsigned int=
 reg)
> > > @@ -162,6 +164,7 @@ static int ad9467_reg_access(struct adi_axi_adc_c=
onv *conv,
> > > unsigned int reg,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!readval) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D ad9467_spi_write(spi, reg, writeval);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n ret;
> > > @@ -310,6 +313,7 @@ static int ad9467_set_scale(struct adi_axi_adc_co=
nv *conv,
> > > int val, int val2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (scale_val[0] !=3D val || scale_val[1] !=3D val2)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 conti=
nue;
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 guard(mutex)(&st->lock);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D ad9467_spi_write(st->spi, AN877_ADC_REG_VREF,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 info->scale_table[i][1]);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0)
> > >=20
> > > --
> > > 2.42.1
> > >=20
> > >  =20
> >=20
> > Alternately, this could probably be solved with spi_bus_lock/unlock
> > and spi_sync_locked rather than introducing a new mutex. =20
>=20
> Hmm, typically you just have your own lock. No reason to lock the spi bus=
. And I also
> have some plans to eventually change this to regmap :)

Bus lock typically implies that we can't let other users grab the bus in be=
tween
for reasons like the chip select needing to be held. I'm not keen on it bei=
ng
used if the locking is just needed for a specific driver to deal with its
associated device and driver state.

Jonathan

>=20
> - Nuno S=C3=A1
>=20


