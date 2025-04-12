Return-Path: <linux-iio+bounces-17997-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBDFA86C9F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943F9445E8F
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0095A1D7995;
	Sat, 12 Apr 2025 10:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3DHAZiY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09D2194A65;
	Sat, 12 Apr 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744455244; cv=none; b=GReEx/SrysBfjQjl5DyK0+Yw8ZkVtRwgKZM0wSyqOYiVeIAyIR7jELssjusxS9YaeXi2utMa5z87r5imdZS3AgMBTQcaj3C0lbYYk3mgw8zKOy7jx4aA/o114buZuZA6RhSKCRYNrbraAZ/qXPOP3XWcEC2igHeQn7rCcETHZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744455244; c=relaxed/simple;
	bh=I0q5hlyfi0DSBsZsUO4t2QmA7tXZThTrX+ardg7gVTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVfG4nNoiqcUK06IIrm45aqV8snmD/KI8g/YWU4IGGnH4wjdc9LT/hsqJCJc66nPaX32paXbWmTtsmEHHZb9V2LdnrH/wRtZpacGazXTQJQ1jh1TgshWH/5Dp3v7I/x/TRKxytUW5EM6LD/xoVBKzuzsM0lV0cWOWihYZmq+WX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3DHAZiY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAD2C4CEE3;
	Sat, 12 Apr 2025 10:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744455244;
	bh=I0q5hlyfi0DSBsZsUO4t2QmA7tXZThTrX+ardg7gVTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L3DHAZiY2tTG8iowbIP1s5Yxhy1ks/Xx1iRMVmRr/mGfrH2N35pLGZuwcO/z7WybU
	 YHLaXoRg/F8KcMlqJmC3zzKTRgEYZWCjGxhwckyo84lPNXMF+kDNh8XvHABYaf1KBl
	 q70OoGK5WCqsRXoF/anElOaO6pJBoQTE4PfRU76Ik+HQCe6yDxWL3LYtcpl5KpTsML
	 ubPSg0NYLZrpES4/TxZqJ8KvctTGX7JXt4ZHbqdDgNaW5R+6Dv1UhjU2l1plcbvWEv
	 sYuPEss/1TSMK0acXetAo97LVX7hn29swhC75mH6EqhRpYVJfC7Qpqr3sobOYFoFA4
	 AQo1IX1O0sVqA==
Date: Sat, 12 Apr 2025 11:53:54 +0100
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
Message-ID: <20250412115354.0b266fae@jic23-huawei>
In-Reply-To: <CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
References: <20250310075638.6979-1-clamor95@gmail.com>
	<20250310075638.6979-3-clamor95@gmail.com>
	<CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 5 Apr 2025 18:23:25 +0300
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D0=BD, 10 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:57 Sv=
yatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > To avoid duplicating sensor functionality and conversion tables, this
> > design allows converting an ADC IIO channel's output directly into a
> > temperature IIO channel. This is particularly useful for devices where
> > hwmon isn't suitable or where temperature data must be accessible throu=
gh
> > IIO.
> >
> > One such device is, for example, the MAX17040 fuel gauge.
> >
> > The temperature data, while technically a product of conversion and thus
> > categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
> > (milli-degree). To account for this, IIO_CHAN_INFO_RAW is used along wi=
th
> > IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.

You've lost me in this description.  The base units of an IIO temperature c=
hannel
are milli-degrees so if the scaling is already right for that you would
be fine using a IIO_CHAN_INFO_PROCESSED channel.

A few other minor things inline.

> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/thermal/thermal-generic-adc.c | 62 ++++++++++++++++++++++++++-
> >  1 file changed, 61 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/th=
ermal-generic-adc.c
> > index ee3d0aa31406..7dcc2e1168a4 100644
> > --- a/drivers/thermal/thermal-generic-adc.c
> > +++ b/drivers/thermal/thermal-generic-adc.c
> > @@ -7,6 +7,7 @@
> >   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> >   */
> >  #include <linux/iio/consumer.h>
> > +#include <linux/iio/iio.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> > @@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops gadc_the=
rmal_ops =3D {
> >         .get_temp =3D gadc_thermal_get_temp,
> >  };
> >
> > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
Even though there is only one. If it is an array use channels.

or stop it being an array and just take a pointer to a single channel
instance.

> > +       {
> > +               .type =3D IIO_TEMP,
> > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > +                                     BIT(IIO_CHAN_INFO_SCALE),
> > +       }
> > +};
> > +
> > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > +                                struct iio_chan_spec const *chan,
> > +                                int *val, int *val2, long mask)
> > +{
> > +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       switch (mask) {
> > +       case IIO_CHAN_INFO_RAW:
> > +               ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               return IIO_VAL_INT;
> > +
> > +       case IIO_CHAN_INFO_SCALE:
> > +               /* scale to a degree centigrade */

As above.  See Documentation/ABI/testing/sysfs-bus-iio
entries from temperature. Scaling of a temperature channel is milli-degrees

This is a bit of a historical artefact. Way back at the start of IIO
when we had relatively few channel types, where possible I matched the
scaling to hwmon.  With hindsight that made things a bit inconsistent
but we are stuck with it as ABI :(

Jonathan

> > +               *val =3D 1;
> > +               *val2 =3D 1000;
> > +               return IIO_VAL_FRACTIONAL;
> > +
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +}
> > +
> > +static const struct iio_info gadc_thermal_iio_info =3D {
> > +       .read_raw =3D gadc_thermal_read_raw,
> > +};
> > +
> > +static int gadc_iio_register(struct device *dev, struct gadc_thermal_i=
nfo *gti)
> > +{
> > +       struct gadc_thermal_info *gtinfo;
> > +       struct iio_dev *indio_dev;
> > +
> > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_the=
rmal_info));
> > +       if (!indio_dev)
> > +               return -ENOMEM;
> > +
> > +       gtinfo =3D iio_priv(indio_dev);
> > +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));

sizeof(*gtinfo) probably slightly better.

> > +
> > +       indio_dev->name =3D dev_name(dev);

What does this end up as?  The convention in IIO is to name after
a part number.  If you have duplicates this isn't how you tell them
apart.  So I'd kind of expect thermal-generic-temp or
something like that.

> > +       indio_dev->info =3D &gadc_thermal_iio_info;
> > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +       indio_dev->channels =3D gadc_thermal_iio_channel;
As above, I'd stop that being an array and use
	indio_dev->channels =3D &gadc_thermal_iio_chanel;
	indio_dev->channels =3D 1;

Unless you think maybe we will get more channels in future, in which case
just rename it channels (which happens to have one element this time)

> > +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_channel=
);
> > +
> > +       return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> >  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
> >                                                  struct gadc_thermal_in=
fo *gti)
> >  {
> > @@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform_devic=
e *pdev)
> >
> >         devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> >
> > -       return 0;
> > +       return gadc_iio_register(&pdev->dev, gti);
> >  }
> >
> >  static const struct of_device_id of_adc_thermal_match[] =3D {
> > --
> > 2.43.0
> > =20
>=20
> Added Jonathan Cameron and linux-iio@vger.kernel.org to list.
>=20
> Jonathan, this is newer version of the thermal-generic-adc you have
> reviewed recently with channels adjusted like proposed in v3.


