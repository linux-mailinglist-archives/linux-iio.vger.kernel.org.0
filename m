Return-Path: <linux-iio+bounces-9818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4631B988FC0
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 16:43:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95521F2191F
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898B1D540;
	Sat, 28 Sep 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knAus5gC"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC3F18654;
	Sat, 28 Sep 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727534629; cv=none; b=Pe0bOdQjbSb02W1M9as8ykyeiGwH3yDrnr3dBHRVhQvcXTwnmv4FeaAU86Cktoqnjtp7RTbPIKHb4hfL2+ou39+QMh1Bx5vIzg18+okswdmL2Id5HhF0jlHcvEaFxOLOzzONA9TCLS8Noksl8DVbfUZjs8aIszy99zJl46o7wWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727534629; c=relaxed/simple;
	bh=03ju+PM9jHEBOcs3wfN0gwiXjoyXhS4e4zgfe3m+xo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kOX6sqNroApx44qXxIXuXduzZMOshQJz4QSY8bAnRXlyqqIUTnI/4CNbl1TMgIigse5R0Pks2rZw+X+3FRq2We3IE7SHMVL1Qksnrt7Q+vCsaTv5qFbfEPaK068llciXVKyyn21Alinu3IaZcI+bLtNjvzHj6YfQ7gkCeYxHqtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knAus5gC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8622AC4CEC3;
	Sat, 28 Sep 2024 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727534628;
	bh=03ju+PM9jHEBOcs3wfN0gwiXjoyXhS4e4zgfe3m+xo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=knAus5gCCmkCgqJtJNaXTfKjmtRmkJpH1zp0PmLf0gRGrOipz0I21FBwp0uybrvQ4
	 +i7douTPejHWFLhJ86wu9CME40/pDA4+pd4OXvmTr5bGUrfMvCH33934FbP0puTycd
	 Ji1gVAqoa8NoN5mmtuwkM4sseVneQVmipw+/ZCQbPoY44e9LCSc54nW0FOFhZ7V8Iq
	 ORjPFD1SJm4U3wCWaZlwh+RW5x0Q4dgVKVI/nkX6Hqm6s7WnWtAr0EpxixJhEuympi
	 HHQS++pVWQEOJlKio7hHTl9ndS5Fz3V35ETBpwoVGWWk7JrQv145MKebNjSP+fE/d2
	 mqbyG3GU/qEYQ==
Date: Sat, 28 Sep 2024 15:43:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
Subject: Re: [PATCH v7 1/8] iio: adc: ad7606: add 'bits' parameter to
 channels macros
Message-ID: <20240928154339.2c886ba4@jic23-huawei>
In-Reply-To: <CA+GgBR94rNX4wLh527EmfO4pzYFU02fQOr-KfzMt6Reyb5QFgA@mail.gmail.com>
References: <20240919130444.2100447-1-aardelean@baylibre.com>
	<20240919130444.2100447-2-aardelean@baylibre.com>
	<CAMknhBFso4RXhhLSN_x1JEDCi70y-2BDVHKAzuh=bp7dt7dgxA@mail.gmail.com>
	<CA+GgBR94rNX4wLh527EmfO4pzYFU02fQOr-KfzMt6Reyb5QFgA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2024 10:11:38 +0200
Alexandru Ardelean <aardelean@baylibre.com> wrote:

> On Mon, Sep 23, 2024 at 4:51=E2=80=AFPM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > On Thu, Sep 19, 2024 at 3:04=E2=80=AFPM Alexandru Ardelean
> > <aardelean@baylibre.com> wrote: =20
> > >
> > > There are some newer additions to the AD7606 family, which support 18=
 bit
> > > precision. Up until now, all chips were 16 bit.
> > >
> > > This change adds a 'bits' parameter to the AD760X_CHANNEL macro and r=
enames
> > > 'ad7606_channels' -> 'ad7606_channels_16bit' for the current devices.
> > >
> > > The AD7606_SW_CHANNEL() macro is also introduced, as a short-hand for=
 IIO
> > > channels in SW mode.
> > >
> > > Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> > > --- =20
> >
> > ...
> > =20
> > > diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> > > index 6649e84d25de..204a343067e5 100644
> > > --- a/drivers/iio/adc/ad7606.h
> > > +++ b/drivers/iio/adc/ad7606.h
> > > @@ -8,7 +8,7 @@
> > >  #ifndef IIO_ADC_AD7606_H_
> > >  #define IIO_ADC_AD7606_H_
> > >
> > > -#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all) {   \
> > > +#define AD760X_CHANNEL(num, mask_sep, mask_type, mask_all, bits) {  =
   \
> > >                 .type =3D IIO_VOLTAGE,                            \
> > >                 .indexed =3D 1,                                   \
> > >                 .channel =3D num,                                 \
> > > @@ -19,24 +19,26 @@
> > >                 .scan_index =3D num,                              \
> > >                 .scan_type =3D {                                  \
> > >                         .sign =3D 's',                            \
> > > -                       .realbits =3D 16,                         \
> > > -                       .storagebits =3D 16,                      \
> > > +                       .realbits =3D (bits),                     \
> > > +                       .storagebits =3D (bits) > 16 ? 32 : 16,   \
> > >                         .endianness =3D IIO_CPU,                  \
> > >                 },                                              \
> > >  }
> > >
> > >  #define AD7605_CHANNEL(num)                            \
> > >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> > > -               BIT(IIO_CHAN_INFO_SCALE), 0)
> > > +               BIT(IIO_CHAN_INFO_SCALE), 0, 16)
> > >
> > > -#define AD7606_CHANNEL(num)                            \
> > > +#define AD7606_CHANNEL(num, bits)                      \
> > >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW),     \
> > >                 BIT(IIO_CHAN_INFO_SCALE),               \
> > > -               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > > +               BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> > >
> > > -#define AD7616_CHANNEL(num)    \
> > > +#define AD7606_SW_CHANNEL(num, bits)   \
> > >         AD760X_CHANNEL(num, BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INF=
O_SCALE),\
> > > -               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO))
> > > +               0, BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), bits)
> > > +
> > > +#define AD7616_CHANNEL(num)    AD7606_SW_CHANNEL(num, 16) =20
> >
> > It looks like the AD7616_CHANNEL macro is no longer used, so can be
> > dropped. Or alternately, don't change the lines below to use
> > AD7606_SW_CHANNEL. =20
>=20
> Well, the AD7616_CHANNEL() macro is still being used for the actual
> AD7616 channels.
> For the AD7606B software channels, the AD7616_CHANNEL() macro was
> being re-used, which seemed like a bit of a lazy/convenient way to do
> it.
>=20
> The patch here, just cleans up that minor quirk, but just for AD7606B.
> The AD7616 driver part, still uses the AD7616_CHANNEL() macro.
>=20
> Though, interestingly, the AD7616_CHANNEL() macro is only used for SW cha=
nnels.
> Maybe in a subsequent patch, the AD7616_CHANNEL() macro can be removed
> altogether.
> I thought about doing it in this series, but decided against it, to
> keep the series small.
It's been a while, and David hasn't said he disagrees with this
argument so I've picked up David's tag whilst applying this.

So David, if you'd rather I didn't then shout!

Series applied to the togreg branch of iio.git and pushed out as testing
for all the normal reasons + I'm waiting for rc1 to rebase on.

Thanks
Jonathan

>=20
> >
> > With either of those changes:
> >
> > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > =20
> > >
> > >  /**
> > >   * struct ad7606_chip_info - chip specific information
> > > diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_sp=
i.c
> > > index 62ec12195307..e00f58a6a0e9 100644
> > > --- a/drivers/iio/adc/ad7606_spi.c
> > > +++ b/drivers/iio/adc/ad7606_spi.c
> > > @@ -67,14 +67,14 @@ static const struct iio_chan_spec ad7616_sw_chann=
els[] =3D {
> > >
> > >  static const struct iio_chan_spec ad7606b_sw_channels[] =3D {
> > >         IIO_CHAN_SOFT_TIMESTAMP(8),
> > > -       AD7616_CHANNEL(0),
> > > -       AD7616_CHANNEL(1),
> > > -       AD7616_CHANNEL(2),
> > > -       AD7616_CHANNEL(3),
> > > -       AD7616_CHANNEL(4),
> > > -       AD7616_CHANNEL(5),
> > > -       AD7616_CHANNEL(6),
> > > -       AD7616_CHANNEL(7),
> > > +       AD7606_SW_CHANNEL(0, 16),
> > > +       AD7606_SW_CHANNEL(1, 16),
> > > +       AD7606_SW_CHANNEL(2, 16),
> > > +       AD7606_SW_CHANNEL(3, 16),
> > > +       AD7606_SW_CHANNEL(4, 16),
> > > +       AD7606_SW_CHANNEL(5, 16),
> > > +       AD7606_SW_CHANNEL(6, 16),
> > > +       AD7606_SW_CHANNEL(7, 16),
> > >  };
> > >
> > >  static const unsigned int ad7606B_oversampling_avail[9] =3D {
> > > --
> > > 2.46.0
> > > =20


