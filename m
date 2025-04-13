Return-Path: <linux-iio+bounces-18036-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E78A8713E
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 11:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7F41742ED
	for <lists+linux-iio@lfdr.de>; Sun, 13 Apr 2025 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA319A298;
	Sun, 13 Apr 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHSFeFw+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE7AD51;
	Sun, 13 Apr 2025 09:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744536510; cv=none; b=l31920NCkGTYTxHQ7WqdKA1sDGuRGaMljCLc8QnFUOYwmzKoq+lbRDie/Scr+vpZmivBhRINxIXvRklNtD05rc0JhniuAYHMQYQfgTowNQzLAT8CXi0W9WFpGFLYEfK7ckH+/fhO31BCRl+hWjSb6plpTY2OXn6NyhQ0CaeyWIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744536510; c=relaxed/simple;
	bh=wt91+h1Fzi4JIQN0tYUAR8bEB0Gxq5nFBwTMgaJDPDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WpcrS0MxgYpQ8PAgkHsyVzIOzvQwvz7LoeO3UUHwfbV8BfdcYfFK8v58K4CeK2tOtb0BFHW+jX83PLeNdWFCti/4OlG5BGuoeGCyDpMrlC8hgsZj7g+iVy0oNam1qn2vRIDq5f8wk9VPj3qal+BugkuRCR0GAqiB63tebvEHxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHSFeFw+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ADCC4CEDD;
	Sun, 13 Apr 2025 09:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744536510;
	bh=wt91+h1Fzi4JIQN0tYUAR8bEB0Gxq5nFBwTMgaJDPDg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FHSFeFw+M2vKFwbOqtZmLY6cm+czeiQ4Tdo4qOeqf0AhVdcaPfpm/E0Muhw0ts2/J
	 BemqU+2e7h5z7e6nJvuOrtieY4LePyUGTt5N1P2+9q4pCVU6wfVyTNFOIm5dkaeMKY
	 zdLuBOAXddjCB+2JfV6SjJJJYtZ5KA8J5irZ3owtkdWJT1NapQ9eR44Atiq5XWDds0
	 uxBTW7nJR11crGwxfX/vrtjWtm+HOkeKsvfQZ34jxX6R36YMv4B55/I5ReSIjsCZpR
	 Wakb78Z9qa+nJi76YdRNn5MD74eRJK2vpzi0PLKSdrOAfp9C8PENAkjhW8VgDBYue4
	 bnPdTOeowh4QQ==
Date: Sun, 13 Apr 2025 10:28:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Laxman Dewangan
 <ldewangan@nvidia.com>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
Message-ID: <20250413102822.0cca4941@jic23-huawei>
In-Reply-To: <CAPVz0n0eqLEjVgMX=4A8jZZ++Ffb_vfCRdqYdizDmuLbXjVb1w@mail.gmail.com>
References: <20250310075638.6979-1-clamor95@gmail.com>
	<20250310075638.6979-3-clamor95@gmail.com>
	<CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
	<20250412115354.0b266fae@jic23-huawei>
	<CAPVz0n0eqLEjVgMX=4A8jZZ++Ffb_vfCRdqYdizDmuLbXjVb1w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 12 Apr 2025 14:06:06 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D0=B1, 12 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13=
:54 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sat, 5 Apr 2025 18:23:25 +0300
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > =D0=BF=D0=BD, 10 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:5=
7 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > To avoid duplicating sensor functionality and conversion tables, th=
is
> > > > design allows converting an ADC IIO channel's output directly into a
> > > > temperature IIO channel. This is particularly useful for devices wh=
ere
> > > > hwmon isn't suitable or where temperature data must be accessible t=
hrough
> > > > IIO.
> > > >
> > > > One such device is, for example, the MAX17040 fuel gauge.
> > > >
> > > > The temperature data, while technically a product of conversion and=
 thus
> > > > categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
> > > > (milli-degree). To account for this, IIO_CHAN_INFO_RAW is used alon=
g with
> > > > IIO_CHAN_INFO_SCALE to provide different degrees of accuracy. =20
> >
> > You've lost me in this description.  The base units of an IIO temperatu=
re channel
> > are milli-degrees so if the scaling is already right for that you would
> > be fine using a IIO_CHAN_INFO_PROCESSED channel.
> >
> > A few other minor things inline.
> > =20
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> > > >  drivers/thermal/thermal-generic-adc.c | 62 +++++++++++++++++++++++=
+++-
> > > >  1 file changed, 61 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/therma=
l/thermal-generic-adc.c
> > > > index ee3d0aa31406..7dcc2e1168a4 100644
> > > > --- a/drivers/thermal/thermal-generic-adc.c
> > > > +++ b/drivers/thermal/thermal-generic-adc.c
> > > > @@ -7,6 +7,7 @@
> > > >   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> > > >   */
> > > >  #include <linux/iio/consumer.h>
> > > > +#include <linux/iio/iio.h>
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/module.h>
> > > >  #include <linux/platform_device.h>
> > > > @@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops gadc=
_thermal_ops =3D {
> > > >         .get_temp =3D gadc_thermal_get_temp,
> > > >  };
> > > >
> > > > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {=
 =20
> > Even though there is only one. If it is an array use channels.
> >
> > or stop it being an array and just take a pointer to a single channel
> > instance.
> > =20
>=20
> There should not be more channels, but tbh, you never know, I will
> rename to channels.
>=20
> > > > +       {
> > > > +               .type =3D IIO_TEMP,
> > > > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > > +                                     BIT(IIO_CHAN_INFO_SCALE),
> > > > +       }
> > > > +};
> > > > +
> > > > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > > > +                                struct iio_chan_spec const *chan,
> > > > +                                int *val, int *val2, long mask)
> > > > +{
> > > > +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > > > +       int ret;
> > > > +
> > > > +       switch (mask) {
> > > > +       case IIO_CHAN_INFO_RAW:
> > > > +               ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +
> > > > +               return IIO_VAL_INT;
> > > > +
> > > > +       case IIO_CHAN_INFO_SCALE:
> > > > +               /* scale to a degree centigrade */ =20
> >
> > As above.  See Documentation/ABI/testing/sysfs-bus-iio
> > entries from temperature. Scaling of a temperature channel is milli-deg=
rees
> >
> > This is a bit of a historical artefact. Way back at the start of IIO
> > when we had relatively few channel types, where possible I matched the
> > scaling to hwmon.  With hindsight that made things a bit inconsistent
> > but we are stuck with it as ABI :(
> > =20
>=20
> RAW channel is in milli-degrees, or this is not enough? I don't get
> your point here tbh. What is wrong? Battery driver requires
> temperature in degree centigrade hence it is scaled to it.

If the battery driver is assuming the temperature from a query to an IIO
provide (to get the processed value) is in degrees centigrade then that
is a bug that needs fixing and it probably implies a scaling problem
in some other driver given I assume someone is using that driver!

The scale here should be 1.  Simplest being to just make a processed
channel and not provide scale at all.

We never explicitly document the internal ABI but the use of
scale and raw must match the userspace ABI which is documented
in Documentation/ABI/testing/sysfs-bus-iio

Jonathan


>=20
> > Jonathan
> > =20
> > > > +               *val =3D 1;
> > > > +               *val2 =3D 1000;
> > > > +               return IIO_VAL_FRACTIONAL;
> > > > +
> > > > +       default:
> > > > +               return -EINVAL;
> > > > +       }
> > > > +}
> > > > +
> > > > +static const struct iio_info gadc_thermal_iio_info =3D {
> > > > +       .read_raw =3D gadc_thermal_read_raw,
> > > > +};
> > > > +
> > > > +static int gadc_iio_register(struct device *dev, struct gadc_therm=
al_info *gti)
> > > > +{
> > > > +       struct gadc_thermal_info *gtinfo;
> > > > +       struct iio_dev *indio_dev;
> > > > +
> > > > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc=
_thermal_info));
> > > > +       if (!indio_dev)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       gtinfo =3D iio_priv(indio_dev);
> > > > +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info)); =20
> >
> > sizeof(*gtinfo) probably slightly better.
> > =20
> > > > +
> > > > +       indio_dev->name =3D dev_name(dev); =20
> >
> > What does this end up as?  The convention in IIO is to name after
> > a part number.  If you have duplicates this isn't how you tell them
> > apart.  So I'd kind of expect thermal-generic-temp or
> > something like that.
> > =20
>=20
> it is "generic-adc-thermal" with this name, it is not present anywhere in=
 IIO.
>=20
> > > > +       indio_dev->info =3D &gadc_thermal_iio_info;
> > > > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > > +       indio_dev->channels =3D gadc_thermal_iio_channel; =20
> > As above, I'd stop that being an array and use
> >         indio_dev->channels =3D &gadc_thermal_iio_chanel;
> >         indio_dev->channels =3D 1;
> >
> > Unless you think maybe we will get more channels in future, in which ca=
se
> > just rename it channels (which happens to have one element this time)
> > =20
> > > > +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_cha=
nnel);
> > > > +
> > > > +       return devm_iio_device_register(dev, indio_dev);
> > > > +}
> > > > +
> > > >  static int gadc_thermal_read_linear_lookup_table(struct device *de=
v,
> > > >                                                  struct gadc_therma=
l_info *gti)
> > > >  {
> > > > @@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform_d=
evice *pdev)
> > > >
> > > >         devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> > > >
> > > > -       return 0;
> > > > +       return gadc_iio_register(&pdev->dev, gti);
> > > >  }
> > > >
> > > >  static const struct of_device_id of_adc_thermal_match[] =3D {
> > > > --
> > > > 2.43.0
> > > > =20
> > >
> > > Added Jonathan Cameron and linux-iio@vger.kernel.org to list.
> > >
> > > Jonathan, this is newer version of the thermal-generic-adc you have
> > > reviewed recently with channels adjusted like proposed in v3. =20
> > =20


