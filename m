Return-Path: <linux-iio+bounces-18000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBA5A86CB7
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4841886C78
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902061C84A4;
	Sat, 12 Apr 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0M4aMFR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B87938DE1;
	Sat, 12 Apr 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744455981; cv=none; b=lP0+SlQbF7EaKBpQ5lizYjhICBuWct1rE22g8B0NGIhAP0IWxEdNDPw9qY4qahVwIuLnFCh/aQqKht5ccaAJMRtaC4nYXgnHmw6ZcfOZFGgYAXmCyy9Wtra+I7AX8argMWfwTgDm8Nt4ZiT3E02lHED2YDz0UQtHPTEqGZTxTBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744455981; c=relaxed/simple;
	bh=Xwx2n1w11EeGH25kbdk3hQrYNioLty2KWpYPiiPJeg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZ9oMfy/6sIOvc5pSUEIamLnSpCuevib8HUrbZAtWfd7aSIQVzlMzl+YvtysGR+vy6pmfZubsyVlJ4wN5f0EpzJtlmu3VvRXpgcGs4wajnOh7ynJvx6rTcDCKrE7pHU2uLgUXZlL9v99x3jzCFefNkguvQTi1yPUA5/wbw0ZF84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h0M4aMFR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-39c2688619bso1785202f8f.1;
        Sat, 12 Apr 2025 04:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744455977; x=1745060777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEQKH0bkHPyosdE+9+BuKjjvelVzT/W2rCC4QTg9N0w=;
        b=h0M4aMFR23zaWvoTgnNS8AK2eOhsG4uVkIowXysmeJ2HnLAd1ASY6ygTk2K1qY/mCO
         Qz3NrMj2ytBmtVXRHumCRjIx3Yv2iirbo9S3PD69d9AuxhlfWmKN1XRt0w6DFqmvPVg5
         PLgnVfMfTyz/WarB1vz15NHIgioCx/6/FczP3yPM0SNrRqWHe/MXoF1ipZKAzmhv+eHZ
         sBZCmTEeD1ISBbfqL3xinws8jmLEJTsKEu4ThLQW2nED07Ypknoq3YbHZbp+fuoamUQU
         NifkHr6QPH9o+wedhjdpwBP5Ju58ahqTgQAUmgrG+mDok7kwgdOVHxkv/sisI6Isgxia
         E/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744455977; x=1745060777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEQKH0bkHPyosdE+9+BuKjjvelVzT/W2rCC4QTg9N0w=;
        b=uVHNkypLy2k8ZsAtr4Jib1xRPuQhoGm/zUXbzfUJxOfUpEPDle0KMkQkj6BXpBtfdX
         yK24lZ57FV5xZ/9qp3v69zWRPny5fBonCQ1a970E/Vj/mxyE1UrAJPgEmSiSxO3WOL/E
         ktXbPNh93PMLuYz4z9v6s1wu4NGUXjsPg4ySzd5VFKosohmvUhf0p5LAZlL6qsRPfrVA
         ZdaJuoSp1J5qqn+xfEnCU/ZeBnjQUFr6A8Ey2YtTzXvZHpw1RaSx/z7utLz0NfWNSfND
         +ZgnsR5VKZ7RxRDnd5Np83D3L+w0vjLqcMKPhxOPKd907k5xFjzlXZ7E6rWm2pXrdqrf
         2IOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlxpSCUjZgCjpxf+OgYoEp38vMMfF9dW2LIi/0dElRE9X59NIR9ndgrUyhrzZe+3zGJ4cgxXE6BU+m@vger.kernel.org, AJvYcCW10fXH/LIqbtIT7jtYf7ui51Rx9FDjq7kplXgKz3dAOiUbX72665QrurO8ZR9BjNVGgkhWIiNOf6UH@vger.kernel.org, AJvYcCW2cQZug74WXGed5nq/dYFJh+7GmdvPjc2iaovPd6/EbkPFMzb4J9Ymgw9rXPtSqbYUkB8//pkbYEA=@vger.kernel.org, AJvYcCXPAP0COjhhLlGvyxl/0JtP5EXvJ7p7JXeW+oQAZFdLWh25DhXt55s1ObyMzuC2QIy71Rus3dhg1s22vj2i@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuk3i8lgPv5VwgzK9aj1mV8tdSUbPAaEVuY+apiFFBytQ+H6ie
	oYMauWVK9eJ8wZohWlmecyhamW4+n+j7/LjNhTnD1SST2FLIKi4VNDqOUk9sgGBdErYQRKxk5tV
	swgg0mGWeU1kkH/Rt5h9IHXIe410=
X-Gm-Gg: ASbGncso1aq+5YIRfvFKkGKwA1YDvHibwqIjiFOhVugZ4llzruaai1CT3V4R1bXeJTy
	wouHOiWNcexz6gOyjC31ViHjLn4O/ZwpoqxuG6KT/3+vbyiw69barFJYVlRtM2v9A2wyuy3npvM
	8RSm/0WmvMEso8+oyLlhJPYrM=
X-Google-Smtp-Source: AGHT+IFmZ9oSGKG8dQnChiY0Qy83xIScN31TSX/I698NuGB8xKYytYAsdO+ebPVVg4Dtrnt5oRYr3cSReLYxizZaxOU=
X-Received: by 2002:a05:6000:184e:b0:39c:cc7:3c5f with SMTP id
 ffacd0b85a97d-39eaaecdacemr5299545f8f.45.1744455977263; Sat, 12 Apr 2025
 04:06:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310075638.6979-1-clamor95@gmail.com> <20250310075638.6979-3-clamor95@gmail.com>
 <CAPVz0n0NA+=+4da8izPvTn3XacdJndyxrvyMY-QvHdie206wVg@mail.gmail.com> <20250412115354.0b266fae@jic23-huawei>
In-Reply-To: <20250412115354.0b266fae@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 12 Apr 2025 14:06:06 +0300
X-Gm-Features: ATxdqUGxoEk1uo883jpX_CkWOlni3XNy2ZUsgKoxuixGs8lUae_HVUKcGAp1E10
Message-ID: <CAPVz0n0eqLEjVgMX=4A8jZZ++Ffb_vfCRdqYdizDmuLbXjVb1w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] thermal: thermal-generic-adc: add temperature
 sensor channel
To: Jonathan Cameron <jic23@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D0=B1, 12 =D0=BA=D0=B2=D1=96=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 13:5=
4 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, 5 Apr 2025 18:23:25 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > =D0=BF=D0=BD, 10 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 09:57 =
Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > To avoid duplicating sensor functionality and conversion tables, this
> > > design allows converting an ADC IIO channel's output directly into a
> > > temperature IIO channel. This is particularly useful for devices wher=
e
> > > hwmon isn't suitable or where temperature data must be accessible thr=
ough
> > > IIO.
> > >
> > > One such device is, for example, the MAX17040 fuel gauge.
> > >
> > > The temperature data, while technically a product of conversion and t=
hus
> > > categorized as IIO_CHAN_INFO_PROCESSED, maintains its unscaled state
> > > (milli-degree). To account for this, IIO_CHAN_INFO_RAW is used along =
with
> > > IIO_CHAN_INFO_SCALE to provide different degrees of accuracy.
>
> You've lost me in this description.  The base units of an IIO temperature=
 channel
> are milli-degrees so if the scaling is already right for that you would
> be fine using a IIO_CHAN_INFO_PROCESSED channel.
>
> A few other minor things inline.
>
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/thermal/thermal-generic-adc.c | 62 +++++++++++++++++++++++++=
+-
> > >  1 file changed, 61 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/=
thermal-generic-adc.c
> > > index ee3d0aa31406..7dcc2e1168a4 100644
> > > --- a/drivers/thermal/thermal-generic-adc.c
> > > +++ b/drivers/thermal/thermal-generic-adc.c
> > > @@ -7,6 +7,7 @@
> > >   * Author: Laxman Dewangan <ldewangan@nvidia.com>
> > >   */
> > >  #include <linux/iio/consumer.h>
> > > +#include <linux/iio/iio.h>
> > >  #include <linux/kernel.h>
> > >  #include <linux/module.h>
> > >  #include <linux/platform_device.h>
> > > @@ -73,6 +74,65 @@ static const struct thermal_zone_device_ops gadc_t=
hermal_ops =3D {
> > >         .get_temp =3D gadc_thermal_get_temp,
> > >  };
> > >
> > > +static const struct iio_chan_spec gadc_thermal_iio_channel[] =3D {
> Even though there is only one. If it is an array use channels.
>
> or stop it being an array and just take a pointer to a single channel
> instance.
>

There should not be more channels, but tbh, you never know, I will
rename to channels.

> > > +       {
> > > +               .type =3D IIO_TEMP,
> > > +               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
> > > +                                     BIT(IIO_CHAN_INFO_SCALE),
> > > +       }
> > > +};
> > > +
> > > +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> > > +                                struct iio_chan_spec const *chan,
> > > +                                int *val, int *val2, long mask)
> > > +{
> > > +       struct gadc_thermal_info *gtinfo =3D iio_priv(indio_dev);
> > > +       int ret;
> > > +
> > > +       switch (mask) {
> > > +       case IIO_CHAN_INFO_RAW:
> > > +               ret =3D gadc_thermal_get_temp(gtinfo->tz_dev, val);
> > > +               if (ret)
> > > +                       return ret;
> > > +
> > > +               return IIO_VAL_INT;
> > > +
> > > +       case IIO_CHAN_INFO_SCALE:
> > > +               /* scale to a degree centigrade */
>
> As above.  See Documentation/ABI/testing/sysfs-bus-iio
> entries from temperature. Scaling of a temperature channel is milli-degre=
es
>
> This is a bit of a historical artefact. Way back at the start of IIO
> when we had relatively few channel types, where possible I matched the
> scaling to hwmon.  With hindsight that made things a bit inconsistent
> but we are stuck with it as ABI :(
>

RAW channel is in milli-degrees, or this is not enough? I don't get
your point here tbh. What is wrong? Battery driver requires
temperature in degree centigrade hence it is scaled to it.

> Jonathan
>
> > > +               *val =3D 1;
> > > +               *val2 =3D 1000;
> > > +               return IIO_VAL_FRACTIONAL;
> > > +
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +}
> > > +
> > > +static const struct iio_info gadc_thermal_iio_info =3D {
> > > +       .read_raw =3D gadc_thermal_read_raw,
> > > +};
> > > +
> > > +static int gadc_iio_register(struct device *dev, struct gadc_thermal=
_info *gti)
> > > +{
> > > +       struct gadc_thermal_info *gtinfo;
> > > +       struct iio_dev *indio_dev;
> > > +
> > > +       indio_dev =3D devm_iio_device_alloc(dev, sizeof(struct gadc_t=
hermal_info));
> > > +       if (!indio_dev)
> > > +               return -ENOMEM;
> > > +
> > > +       gtinfo =3D iio_priv(indio_dev);
> > > +       memcpy(gtinfo, gti, sizeof(struct gadc_thermal_info));
>
> sizeof(*gtinfo) probably slightly better.
>
> > > +
> > > +       indio_dev->name =3D dev_name(dev);
>
> What does this end up as?  The convention in IIO is to name after
> a part number.  If you have duplicates this isn't how you tell them
> apart.  So I'd kind of expect thermal-generic-temp or
> something like that.
>

it is "generic-adc-thermal" with this name, it is not present anywhere in I=
IO.

> > > +       indio_dev->info =3D &gadc_thermal_iio_info;
> > > +       indio_dev->modes =3D INDIO_DIRECT_MODE;
> > > +       indio_dev->channels =3D gadc_thermal_iio_channel;
> As above, I'd stop that being an array and use
>         indio_dev->channels =3D &gadc_thermal_iio_chanel;
>         indio_dev->channels =3D 1;
>
> Unless you think maybe we will get more channels in future, in which case
> just rename it channels (which happens to have one element this time)
>
> > > +       indio_dev->num_channels =3D ARRAY_SIZE(gadc_thermal_iio_chann=
el);
> > > +
> > > +       return devm_iio_device_register(dev, indio_dev);
> > > +}
> > > +
> > >  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
> > >                                                  struct gadc_thermal_=
info *gti)
> > >  {
> > > @@ -153,7 +213,7 @@ static int gadc_thermal_probe(struct platform_dev=
ice *pdev)
> > >
> > >         devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
> > >
> > > -       return 0;
> > > +       return gadc_iio_register(&pdev->dev, gti);
> > >  }
> > >
> > >  static const struct of_device_id of_adc_thermal_match[] =3D {
> > > --
> > > 2.43.0
> > >
> >
> > Added Jonathan Cameron and linux-iio@vger.kernel.org to list.
> >
> > Jonathan, this is newer version of the thermal-generic-adc you have
> > reviewed recently with channels adjusted like proposed in v3.
>

